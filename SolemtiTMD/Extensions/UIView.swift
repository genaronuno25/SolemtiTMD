//
//  UIView.swift
//  SolemtiTMD
//
//  Created by gerardo.nuno on 10/04/22.
//

import UIKit

extension UIView {
    func applyShadow(radius: CGFloat, opacity: Float, offsetW: Int, offsetH: Int) {
        let color: UIColor = .black
        self.layer.shadowRadius = radius
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = CGSize(width: offsetW, height: offsetH)
        self.layer.masksToBounds = false
    }
}
