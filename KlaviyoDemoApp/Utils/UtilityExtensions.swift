//
//  UtilityExtensions.swift
//  KlaviyoDemoApp
//
//  Created by Kiran Patel on 8/11/22.
//

import Foundation
import UIKit

extension UIViewController {
    func showInputDialog(title:String? = nil,
                         subtitle:String? = nil,
                         actionTitle:String? = "Update",
                         cancelTitle:String? = "Cancel",
                         textValue:String? = nil,
                         inputPlaceholder:String? = "Enter Email ID",
                         cancelHandler: ((UIAlertAction) -> Swift.Void)? = nil,
                         actionHandler: ((_ text: String?) -> Void)? = nil) {

        let alert = UIAlertController(title: title, message: subtitle, preferredStyle: .alert)
        alert.addTextField { (textField:UITextField) in
            textField.placeholder = inputPlaceholder
            textField.text = textValue
        }
        alert.addAction(UIAlertAction(title: actionTitle, style: .default, handler: { (action:UIAlertAction) in
            guard let textField =  alert.textFields?.first else {
                actionHandler?(nil)
                return
            }
            actionHandler?(textField.text)
        }))
        alert.addAction(UIAlertAction(title: cancelTitle, style: .cancel, handler: cancelHandler))

        self.present(alert, animated: true, completion: nil)
    }
}


extension Notification.Name {
     static let profileChange = Notification.Name("user.profileChange")
 }
