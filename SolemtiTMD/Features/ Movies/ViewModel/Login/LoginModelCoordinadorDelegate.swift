//
//  LoginModelCoordinadorDelegate.swift
//  SolemtiTMD
//
//  Created by gerardo.nuno on 10/04/22.
//

import UIKit
protocol LoginModelCoordinadorDelegate: class {
    func showErrorLogin(withError error: Error)
}
