//
//  String+Extension.swift
//  OVS
//
//  Created by Osvaldo Pirrello on 02/02/21.
//  Copyright © 2021 OverApp. All rights reserved.
//

import UIKit

extension String {
    
    /// Localized string
    var localized: String {
        return NSLocalizedString(
            self,
            tableName: nil,
            bundle: Bundle.main,
            value: "",
            comment: "")
    }
    
    /// Localized string from table
    func localized(from tableName: String? = nil) -> String {
        return NSLocalizedString(
            self,
            tableName: tableName,
            bundle: Bundle.main,
            value: "",
            comment: "")
    }
    
    /// Args
    func args(_ args: String...) -> String {
        return String(format: self, arguments: args)
    }
    
    /// Pretty printed JSON
    var prettyPrintedJson: NSString? {
        guard
            let data = self.data(using: .utf8),
            let object = try? JSONSerialization.jsonObject(with: data, options: []),
            let info = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
            let prettyPrintedString = NSString(data: info, encoding: String.Encoding.utf8.rawValue) else { return nil }
        
        return prettyPrintedString
    }
    
    /// Returns an array of strings at new lines.
    public func lines() -> [String] {
        components(separatedBy: .newlines)
    }
    
    /// Replace characters in range.
    func replacingCharacters(in range: NSRange, with replacement: String) -> String {
        guard range.location <= self.count else { return self }
        let maxLength = self.count
        var limitedRange = NSRange(location: range.location, length: range.length)
        if range.location + range.length > maxLength {
            limitedRange.length = self.count - range.location
        }
        guard let swiftRange = Range(limitedRange, in: self) else { return self }
        return replacingCharacters(in: swiftRange, with: replacement)
    }
    
    func leftSlice(limit: Int) -> String {
        guard limit < count else { return self }
        let rangeBegin = startIndex
        let rangeEnd = index(startIndex, offsetBy: limit)
        return String(self[rangeBegin..<rangeEnd])
    }
    
    func slice(from: Int, length: Int) -> String? {
        guard from < count, from + length < count else { return nil }
        let fromIndex = index(startIndex, offsetBy: from)
        let toIndex = index(fromIndex, offsetBy: length)
        return String(self[fromIndex..<toIndex])
    }
    
    func stringWithMeasure(_ unit: Unit) -> String {
        let formatter = MeasurementFormatter()
        formatter.unitOptions = .providedUnit
        formatter.unitStyle = .short
        return formatter.string(from: Measurement(value: Double(self) ?? 0.0, unit: unit))
    }
    
    func isValidEmail() -> Bool {
        // here, `try!` will always succeed because the pattern is valid
        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
    
    // MARK: - Dates
    
    /**
     Default toFormattedDate conversion
     */
    public func toString(format: DateFormatType) -> String? {
        return Date(fromString: self, format: .isoDate)?.toString(format: format)
    }
    
    var digits: String {
        return components(separatedBy: CharacterSet.decimalDigits.inverted)
            .joined()
    }
}
