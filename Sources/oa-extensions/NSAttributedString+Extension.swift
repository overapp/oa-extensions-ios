//
//  NSAttributedString+Extension.swift
//  oa-extensions
//
//  Created by Osvaldo Pirrello on 06/04/22.
//  Copyright © 2022 OverApp. All rights reserved.
//

import UIKit

public extension NSAttributedString {
    
    func applyFont(_ font: UIFont) -> NSAttributedString {
        NSMutableAttributedString(attributedString: self).font(font)
    }
    
    func applyLetterSpacing(_ spacing: CGFloat) -> NSAttributedString {
        NSMutableAttributedString(attributedString: self).kern(spacing)
    }
    
    func applyLineHeight(_ height: CGFloat) -> NSAttributedString {
        NSMutableAttributedString(attributedString: self).lineSpacing(height)
    }
    
    func applyTitleColor(_ color: UIColor) -> NSAttributedString {
        NSMutableAttributedString(attributedString: self).color(color)
    }
    
    func applyUnderline(_ underline: Bool) -> NSAttributedString {
        NSMutableAttributedString(attributedString: self).underline(style: underline ? .single : nil)
    }
    
    func applyUppercase(_ uppercase: Bool) -> NSAttributedString {
        NSMutableAttributedString(attributedString: self).uppercase(uppercase)
    }
    
    func setStringKeepingAttributes(_ string: String?) -> NSAttributedString {
        let mutable = NSMutableAttributedString(attributedString: self)
        if let s = string {
            mutable.mutableString.setString(s)
        }
        return mutable
    }
    
}

public extension NSAttributedString {
    /**
    Returns a new mutable string with characters from a given character set removed.
    See http://panupan.com/2012/06/04/trim-leading-and-trailing-whitespaces-from-nsmutableattributedstring/
    - Parameters:
      - charSet: The character set with which to remove characters.
    - returns: A new string with the matching characters removed.
    */
    func trimmingCharacters(in set: CharacterSet) -> NSAttributedString {
        let modString = NSMutableAttributedString(attributedString: self)
        modString.trimCharacters(in: set)
        return NSAttributedString(attributedString: modString)
    }
}

public extension NSMutableAttributedString {
    /**
    Modifies this instance of the string to remove characters from a given character set from
    the beginning and end of the string.
    See http://panupan.com/2012/06/04/trim-leading-and-trailing-whitespaces-from-nsmutableattributedstring/
    - Parameters:
      - charSet: The character set with which to remove characters.
    */
    func trimCharacters(in set: CharacterSet) {
        var range = (string as NSString).rangeOfCharacter(from: set)

        // Trim leading characters from character set.
        while range.length != 0 && range.location == 0 {
            replaceCharacters(in: range, with: "")
            range = (string as NSString).rangeOfCharacter(from: set)
        }

        // Trim trailing characters from character set.
        range = (string as NSString).rangeOfCharacter(from: set, options: .backwards)
        while range.length != 0 && NSMaxRange(range) == length {
            replaceCharacters(in: range, with: "")
            range = (string as NSString).rangeOfCharacter(from: set, options: .backwards)
        }
    }

}

public extension NSMutableAttributedString {
    
    fileprivate var range: NSRange {
        return NSRange(location: 0, length: length)
    }
    
    fileprivate var paragraphStyle: NSMutableParagraphStyle? {
        return attributes(at: 0, effectiveRange: nil)[.paragraphStyle] as? NSMutableParagraphStyle
    }
    
}

// MARK: - Font

public extension NSMutableAttributedString {
    /**
     Applies a font to the entire string.
     
     - parameter font: The font.
     */
    @discardableResult
    func font(_ font: UIFont) -> Self {
        addAttribute(.font, value: font, range: range)
        return self
    }
    
    /**
     Applies a font to the entire string.
     
     - parameter name: The font name.
     - parameter size: The font size.
     
     Note: If the specified font name cannot be loaded, this method will fallback to the system font at the specified size.
     */
    @discardableResult
    func font(name: String, size: CGFloat) -> Self {
        addAttribute(.font, value: UIFont(name: name, size: size) ?? .systemFont(ofSize: size), range: range)
        return self
    }
}

// MARK: - Paragraph style

public extension NSMutableAttributedString {
    
    /**
     Applies a text alignment to the entire string.
     
     - parameter alignment: The text alignment.
     */
    @discardableResult
    func alignment(_ alignment: NSTextAlignment) -> Self {
        let paragraphStyle = self.paragraphStyle ?? NSMutableParagraphStyle()
        paragraphStyle.alignment = alignment
        
        addAttribute(.paragraphStyle, value: paragraphStyle, range: range)
        
        return self
    }
    
    /**
     Applies line spacing to the entire string.
     
     - parameter lineSpacing: The line spacing amount.
     */
    @discardableResult
    func lineSpacing(_ lineSpacing: CGFloat) -> Self {
        let paragraphStyle = self.paragraphStyle ?? NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        
        addAttribute(.paragraphStyle, value: paragraphStyle, range: range)
        
        return self
    }
    
    /**
     Applies paragraph spacing to the entire string.
     
     - parameter paragraphSpacing: The paragraph spacing amount.
     */
    @discardableResult
    func paragraphSpacing(_ paragraphSpacing: CGFloat) -> Self {
        let paragraphStyle = self.paragraphStyle ?? NSMutableParagraphStyle()
        paragraphStyle.paragraphSpacing = paragraphSpacing
        
        addAttribute(.paragraphStyle, value: paragraphStyle, range: range)
        
        return self
    }
    
    /**
     Applies a line break mode to the entire string.
     
     - parameter mode: The line break mode.
     */
    @discardableResult
    func lineBreak(_ mode: NSLineBreakMode) -> Self {
        let paragraphStyle = self.paragraphStyle ?? NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = mode
        
        addAttribute(.paragraphStyle, value: paragraphStyle, range: range)
        
        return self
    }

    /**
     Applies a line height multiplier to the entire string.
     
     - parameter multiple: The line height multiplier.
     */
    @discardableResult
    func lineHeight(multiple: CGFloat) -> Self {
        let paragraphStyle = self.paragraphStyle ?? NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = multiple
        
        addAttribute(.paragraphStyle, value: paragraphStyle, range: range)
        
        return self
    }
    
    /**
     Applies a first line head indent to the string.
     
     - parameter indent: The first line head indent amount.
     */
    @discardableResult
    func firstLineHeadIndent(_ indent: CGFloat) -> Self {
        let paragraphStyle = self.paragraphStyle ?? NSMutableParagraphStyle()
        paragraphStyle.firstLineHeadIndent = indent
        
        addAttribute(.paragraphStyle, value: paragraphStyle, range: range)
        
        return self
    }
    
    /**
     Applies a head indent to the string.
     
     - parameter indent: The head indent amount.
     */
    @discardableResult
    func headIndent(_ indent: CGFloat) -> Self {
        let paragraphStyle = self.paragraphStyle ?? NSMutableParagraphStyle()
        paragraphStyle.headIndent = indent
        
        addAttribute(.paragraphStyle, value: paragraphStyle, range: range)
        
        return self
    }
    
    /**
     Applies a tail indent to the string.
     
     - parameter indent: The tail indent amount.
     */
    @discardableResult
    func tailIndent(_ indent: CGFloat) -> Self {
        let paragraphStyle = self.paragraphStyle ?? NSMutableParagraphStyle()
        paragraphStyle.tailIndent = indent
        
        addAttribute(.paragraphStyle, value: paragraphStyle, range: range)
        
        return self
    }

    /**
     Applies a minimum line height to the entire string.
     
     - parameter height: The minimum line height.
     */
    @discardableResult
    func minimumLineHeight(_ height: CGFloat) -> Self {
        let paragraphStyle = self.paragraphStyle ?? NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = height
        
        addAttribute(.paragraphStyle, value: paragraphStyle, range: range)
        
        return self
    }
    
    /**
     Applies a maximum line height to the entire string.
     
     - parameter height: The maximum line height.
     */
    @discardableResult
    func maximumLineHeight(_ height: CGFloat) -> Self {
        let paragraphStyle = self.paragraphStyle ?? NSMutableParagraphStyle()
        paragraphStyle.maximumLineHeight = height
        
        addAttribute(.paragraphStyle, value: paragraphStyle, range: range)
        
        return self
    }
    
    /**
     Applies a base writing direction to the entire string.
     
     - parameter direction: The base writing direction.
     */
    @discardableResult
    func baseWritingDirection(_ direction: NSWritingDirection) -> Self {
        let paragraphStyle = self.paragraphStyle ?? NSMutableParagraphStyle()
        paragraphStyle.baseWritingDirection = direction
        
        addAttribute(.paragraphStyle, value: paragraphStyle, range: range)
        
        return self
    }
    
    /**
     Applies a paragraph spacing before amount to the string.
     
     - parameter spacing: The distance between the paragraph’s top and the beginning of its text content.
     */
    @discardableResult
    func paragraphSpacingBefore(_ spacing: CGFloat) -> Self {
        let paragraphStyle = self.paragraphStyle ?? NSMutableParagraphStyle()
        paragraphStyle.paragraphSpacingBefore = spacing
        
        addAttribute(.paragraphStyle, value: paragraphStyle, range: range)
        
        return self
    }
}

// MARK: - Foreground color

public extension NSMutableAttributedString {
    /**
     Applies the given color over the entire string, as the foreground color.
     
     - parameter color: The color to apply.
     */
    @discardableResult @nonobjc
    func color(_ color: UIColor) -> Self {
        addAttribute(.foregroundColor, value: color, range: range)
        return self
    }
    
}

// MARK: - Underline, kern, strikethrough, stroke, shadow, text effect

public extension NSMutableAttributedString {
    /**
     Applies a single underline under the entire string.
     
     - parameter style: The `NSUnderlineStyle` to apply. Defaults to `.styleSingle`.
     */
    @discardableResult
    func underline(style: NSUnderlineStyle?, color: UIColor? = nil) -> Self {
        if let style = style {
            addAttribute(.underlineStyle, value: style.rawValue, range: range)
            if let color = color {
                addAttribute(.underlineColor, value: color, range: range)
            }
        }
        else {
            removeAttribute(.underlineStyle, range: range)
            removeAttribute(.underlineColor, range: range)
        }
        return self
    }
    
    /**
     Applies uppercase the entire string.
     
     - parameter uppercase: define if string should be uppercased or not.
     */
    @discardableResult
    func uppercase(_ uppercase: Bool) -> Self {
        let result = uppercase
            ? (string as NSString).substring(with: range).uppercased()
            : (string as NSString).substring(with: range).lowercased()
        
        enumerateAttributes(in: range, options: []) {_, range, _ in
            replaceCharacters(in: range, with: result)
        }
        return self
    }

    /**
     Applies a kern (spacing) value to the entire string.
     
     - parameter value: The space between each character in the string.
     */
    @discardableResult
    func kern(_ value: CGFloat) -> Self {
        addAttribute(.kern, value: value, range: range)
        return self
    }
    
    /**
     Applies a strikethrough to the entire string.
     
     - parameter style: The `NSUnderlineStyle` to apply. Defaults to `.styleSingle`.
     - parameter color: The underline color. Defaults to the color of the text.
     */
    @discardableResult
    func strikethrough(style: NSUnderlineStyle = .single, color: UIColor? = nil) -> Self {
        addAttribute(.strikethroughStyle, value: style.rawValue, range: range)
        
        if let color = color {
            addAttribute(.strikethroughColor, value: color, range: range)
        }
        
        return self
    }
    
    /**
     Applies a stroke to the entire string.
     
     - parameter color: The stroke color.
     - parameter width: The stroke width.
     */
    @discardableResult
    func stroke(color: UIColor, width: CGFloat) -> Self {
        addAttributes([
            .strokeColor : color,
            .strokeWidth : width
        ], range: range)
        
        return self
    }
    
    /**
     Applies a shadow to the entire string.
     
     - parameter color: The shadow color.
     - parameter radius: The shadow blur radius.
     - parameter offset: The shadow offset.
     */
    @discardableResult
    func shadow(color: UIColor, radius: CGFloat, offset: CGSize) -> Self {
        let shadow = NSShadow()
        shadow.shadowColor = color
        shadow.shadowBlurRadius = radius
        shadow.shadowOffset = offset
        
        addAttribute(.shadow, value: shadow, range: range)
        
        return self
    }
    
}

// MARK: - Background color

public extension NSMutableAttributedString {
    
    /**
     Applies a background color to the entire string.
     
     - parameter color: The color to apply.
     */
    @discardableResult @nonobjc
    func backgroundColor(_ color: UIColor) -> Self {
        addAttribute(.backgroundColor, value: color, range: range)
        return self
    }
    
}

public extension NSMutableAttributedString {
    
    /**
     Applies a baseline offset to the entire string.
     
     - parameter offset: The offset value.
     */
    @discardableResult
    func baselineOffset(_ offset: Float) -> Self {
        addAttribute(.baselineOffset, value: NSNumber(value: offset), range: range)
        return self
    }
}

func +(lhs: NSMutableAttributedString, rhs: NSAttributedString) -> NSMutableAttributedString {
    let lhs = NSMutableAttributedString(attributedString: lhs)
    lhs.append(rhs)
    return lhs
}

func +=(lhs: NSMutableAttributedString, rhs: NSAttributedString) {
    lhs.append(rhs)
}
