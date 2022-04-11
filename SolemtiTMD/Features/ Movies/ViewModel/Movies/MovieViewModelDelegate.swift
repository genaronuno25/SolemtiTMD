//
//  UpcomingViewModelDelegate.swift
//  TheMovie
//
//  Created by gerardo.nuno on 08/04/22.
//

import Foundation
protocol MovieViewModelDelegate: class {
    func updateScreen()
    func startRequest()
    func endRequest()
}
