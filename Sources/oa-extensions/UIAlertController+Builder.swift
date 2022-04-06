//
//  UIAlertController+Builder.swift
//  oa-extensions
//
//  Created by Osvaldo Pirrello on 06/04/22.
//  Copyright © 2021 OverApp. All rights reserved.
//

import UIKit

/*
 * This extension implements a Builder pattern to use with the
 * UIAlertViewController. You can just pass in localization keys from your
 * localizable.strings file instead of direct strings. It will localize the
 * strings or just use the string given if not available.
 *
 * To localize the addOkAction/addDeleteAction/addCancelAction just add a key to
 * you localizable.strings for "OK", "Delete" and "Cancel" respectively.
 *
 * Sample:
 *
 * UIAlertController.Builder()
 *    .withTitle("this_is_a_key_from_localizable.strings")
 *    .withMessage("This is a normal message")
 *    .addOkAction()
 *    .show(in: UIViewController) OR .build() to get back the UIAlertController directly
 */
public extension UIAlertController {

    static func okAlert(withTitle title: String? = nil, withMessage message: String? = nil) -> UIAlertController.Builder {
        return UIAlertController.Builder()
            .withTitle(title)
            .withMessage(message)
            .addOkAction()
    }

    class Builder {
        
        private var preferredStyle: UIAlertController.Style = .alert
        private var title: String? = nil
        private var message: String? = nil
        private var actions: [UIAlertAction] = [UIAlertAction]()
        private var popoverSourceView: UIView? = nil
        private var sourceRect: CGRect? = nil
        private var activityIndicatorView: UIActivityIndicatorView? = nil

        init() {}

        func preferredStyle(_ style: UIAlertController.Style) -> Builder {
            self.preferredStyle = style
            return self
        }

        func withTitle(_ title: String?) -> Builder {
            self.title = unwrapStringAndLocalize(title)
            return self
        }

        func withMessage(_ message: String?) -> Builder {
            self.message = unwrapStringAndLocalize(message)
            return self
        }

        func withPopoverSourceView(_ view: UIView?) -> Builder {
            self.popoverSourceView = view
            return self
        }

        func withSourceRect(_ rect: CGRect?) -> Builder {
            self.sourceRect = rect
            return self
        }
        
        func withLoadingView() -> Builder {
            self.activityIndicatorView = UIActivityIndicatorView(
                frame: CGRect(
                    x: 8,
                    y: 4,
                    width: 48,
                    height: 48)
            )
            self.activityIndicatorView?.hidesWhenStopped = true
            self.activityIndicatorView?.style = .medium
            self.activityIndicatorView?.startAnimating()
            return self
        }

        func addOkAction(handler: ((UIAlertAction) -> Swift.Void)? = nil) -> Builder {
            return addDefaultActionWithTitle("OK", handler: handler)
        }

        func addDeleteAction(handler: ((UIAlertAction) -> Swift.Void)? = nil) -> Builder {
            return addDestructiveActionWithTitle("Delete", handler: handler)
        }

        func addCancelAction(handler: ((UIAlertAction) -> Swift.Void)? = nil) -> Builder {
            return addCancelActionWithTitle("Cancel", handler: handler)
        }

        func addDefaultActionWithTitle(_ title: String, handler: ((UIAlertAction) -> Swift.Void)? = nil) -> Builder {
            return addActionWithTitle(title, style: .default, handler: handler)
        }

        func addDestructiveActionWithTitle(_ title: String, handler: ((UIAlertAction) -> Swift.Void)? = nil) -> Builder {
            return addActionWithTitle(title, style: .destructive, handler: handler)
        }

        func addCancelActionWithTitle(_ title: String, handler: ((UIAlertAction) -> Swift.Void)? = nil) -> Builder {
            return addActionWithTitle(title, style: .cancel, handler: handler)
        }

        func addActionWithTitle(_ title: String?, style: UIAlertAction.Style = .default, handler: ((UIAlertAction) -> Swift.Void)?) -> Builder {
            let action = UIAlertAction(title: title, style: style, handler: handler)
            actions.append(action)
            return self
        }

        func show(in viewController: UIViewController, animated: Bool = true, completion: (() -> Swift.Void)? = nil) {
            viewController.present(build(), animated: animated, completion: completion)
        }
        
        func build() -> UIAlertController {
            let alert = UIAlertController(title: self.title, message: self.message, preferredStyle: self.preferredStyle)

            if let popoverSourceView = self.popoverSourceView {
                alert.popoverPresentationController?.sourceView = popoverSourceView
            }

            if let sourceRect = self.sourceRect {
                alert.popoverPresentationController?.sourceRect = sourceRect
            }
            
            if let activityIndicatorView = self.activityIndicatorView {
                alert.view.addSubview(activityIndicatorView)
            }

            actions.forEach { (action) in
                alert.addAction(action)
            }

            return alert
        }

        private func unwrapStringAndLocalize(_ value: String?) -> String? {
            guard let value = value else { return nil }
            return NSLocalizedString(value, comment: "")
        }
    }
}
