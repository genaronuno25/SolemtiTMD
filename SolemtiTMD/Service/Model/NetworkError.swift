//
//  NetworkError.swift
//  SolemtiTMD
//
//  Created by gerardo.nuno on 10/04/22.
//

import Foundation

enum NetworkError: LocalizedError {
    case noDataProvided
    case failedToDecode
    case invalidHttpBodyData
    case invalidSessionId
    case keychainReadError
    case invalidCredentials

    var errorDescription: String? {
        switch self {
        case .noDataProvided:
            return "No data was provided by server"
        case .failedToDecode:
            return "Failed to decode JSON from server"
        case .invalidHttpBodyData:
            return "There is invalid data for HTTP body"
        case .invalidSessionId:
            return "There is invalid session id. Try to re-login"
        case .keychainReadError:
            return "There is keychain reading error"
        case .invalidCredentials:
            return "There is invalid credentials. Try to re-login"
        }
    }
}
