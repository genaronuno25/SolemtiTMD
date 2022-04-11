//
//  UIAlertController.swift
//  SolemtiTMD
//
//  Created by gerardo.nuno on 10/04/22.
//

import UIKit

extension UIAlertController {
    static func showErrorAlert(on vc: UIViewController, message: String?) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "Error occurred",
                                                    message: message,
                                                    preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            vc.present(alertController, animated: true, completion: nil)
        }
    }
}
