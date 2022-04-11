//
//  CustomLabel.swift
//  TheMovie
//
//  Created by gerardo.nuno on 08/04/22.
//

import UIKit

class CustomLabel: UILabel {
 
    // lineSpacing is a actually a private UILabel property
    // fuck you, Apple
       @IBInspectable var labelLineSpacing: CGFloat = 0 {
           didSet {
               self.updateLineSpacing()
           }
       }
       
       override var text: String? {
           didSet {
               self.updateLineSpacing()
           }
       }
       
       override var textColor: UIColor! {
           didSet {
               self.updateLineSpacing()
           }
       }
       
       override var intrinsicContentSize: CGSize {
           var size = super.intrinsicContentSize
           size.height += 5
           
           return size
       }
       
       func updateLineSpacing() {
           
           guard let text = self.text,
               let font = self.font,
               let textColor = self.textColor else { return }
           
           let paragraphStyle = NSMutableParagraphStyle()
           paragraphStyle.lineSpacing = self.labelLineSpacing
           paragraphStyle.alignment = self.textAlignment
           paragraphStyle.lineBreakMode = self.lineBreakMode
           self.attributedText = NSAttributedString(string: text,
                                                    attributes: [.font: font,
                                                                 .foregroundColor: textColor, .paragraphStyle: paragraphStyle])
       }

}
