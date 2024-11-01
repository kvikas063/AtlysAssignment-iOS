//
//  LoginViewController+Extension.swift
//  AtlysAssignment-iOS
//
//  Created by Vikas Kumar on 01/11/24.
//
import UIKit

extension LoginViewController: MobileNumberKeyboardDelegate {
    
    func keyboardWillShow() {
        if view.frame.origin.y >= 0 {
            view.frame.origin.y = view.frame.origin.y - 150
        }
    }

    func keyboardWillHide() {
        view.frame.origin.y = 0
    }
}

extension LoginViewController: MobileNumberDelegate {
    
    func didContinueTapped(with number: String) {
        // Call Login API
        // Check Login API Response
        // Show Alert with Success or Error
        var message = AppString.Login.AlertMessage
        message = message.replacingOccurrences(of: "<Mobile>", with: number)
        
        let alert = UIAlertController(
            title: AppString.Login.AlertTitle,
            message: message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
}
