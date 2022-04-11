//
//  Alert.swift
//  AppMovies
//
//  Created by gerardo.nuno on 08/04/22.
//

import Foundation
import PopupDialog

protocol AlertDelegate {
    func didTapCancel()
    func didTapAccept()
}

class AlertHelper {
    
    private(set) var title: String
    private(set) var message: String
    private(set) var popup: PopupDialog
    
    var delegate: AlertDelegate?
    
    init(withTitle title: String, withMessage message: String) {
        self.title = title
        self.message = message
        self.popup = PopupDialog(title: title, message: message)
        self.setAppearance()
    }
    
    func showWarning() -> PopupDialog {
        let buttonCancel = CancelButton(title: "OK") {
            self.delegate?.didTapCancel()
        }
        
        popup.addButtons([buttonCancel])
        popup.transitionStyle = .fadeIn
        popup.buttonAlignment = .horizontal
        
        return popup
    }

    func show() -> PopupDialog  {
        let buttonCancel = CancelButton(title: "CANCEL") {
            self.delegate?.didTapCancel()
        }
        
        let buttonAccept = DefaultButton(title: "OK", height: 60) {
            self.delegate?.didTapAccept()
        }
        
        popup.addButtons([buttonCancel,buttonAccept])
        popup.transitionStyle = .fadeIn
        popup.buttonAlignment = .horizontal
        
        return popup
    }
    
    func setAppearance()  {
        // Customize dialog appearance
        let pv = PopupDialogDefaultView.appearance()
        pv.titleFont    = UIFont(name: "HelveticaNeue-Light", size: 16)!
        pv.titleColor   = .white
        pv.messageFont  = UIFont(name: "HelveticaNeue", size: 14)!
        pv.messageColor = UIColor(white: 0.8, alpha: 1)
        
        // Customize the container view appearance
        let pcv = PopupDialogContainerView.appearance()
        pcv.backgroundColor = UIColor(red:0.23, green:0.23, blue:0.27, alpha:1.00)
        pcv.cornerRadius    = 2
        pcv.shadowEnabled   = true
        pcv.shadowColor     = .black
        
        // Customize overlay appearance
        let ov = PopupDialogOverlayView.appearance()
        ov.blurEnabled     = true
        ov.blurRadius      = 30
        ov.liveBlurEnabled = true
        ov.opacity         = 0.7
        ov.color           = .black
        
        // Customize default button appearance
        let db = DefaultButton.appearance()
        db.titleFont      = UIFont(name: "HelveticaNeue-Medium", size: 14)!
        db.titleColor     = .white
        db.buttonColor    = UIColor(red:0.25, green:0.25, blue:0.29, alpha:1.00)
        db.separatorColor = UIColor(red:0.20, green:0.20, blue:0.25, alpha:1.00)
        
        // Customize cancel button appearance
        let cb = CancelButton.appearance()
        cb.titleFont      = UIFont(name: "HelveticaNeue-Medium", size: 14)!
        cb.titleColor     = UIColor(white: 0.6, alpha: 1)
        cb.buttonColor    = UIColor(red:0.25, green:0.25, blue:0.29, alpha:1.00)
        cb.separatorColor = UIColor(red:0.20, green:0.20, blue:0.25, alpha:1.00)
        
        let buttonAppearance = DefaultButton.appearance()
        
        // Default button
        buttonAppearance.titleFont      = .systemFont(ofSize: 14)
        buttonAppearance.titleColor     = .yellow
        buttonAppearance.buttonColor    = .clear
        
        
        // Below, only the differences are highlighted
        
        // Cancel button
        CancelButton.appearance().titleColor = .lightGray
    }
}

