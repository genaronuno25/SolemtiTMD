//
//  AuthorizationService.swift
//  SolemtiTMD
//
//  Created by gerardo.nuno on 10/04/22.
//

import Foundation

final class AuthorizationService {

    // MARK: - Properties

    static var sessionId: String? {
        return UserDefaults.standard.string(forKey: "sessionId")
    }
    
    private let profileService = ProfileService()
    private let defaults = UserDefaults.standard
   
    // MARK: - Methods

    // swiftlint:disable cyclomatic_complexity
    func login(login: String,
               password: String,
               completion: @escaping (Result<Void, Error>) -> Void) {
        getToken { [weak self] (result) in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let token):
                guard let token = token else {
                    return
                }
                self.validateToken(token: token, login: login, password: password) { [weak self] (result) in
                    guard let self = self else {
                        return
                    }
                    switch result {
                    case .success(let token):
                        guard let token = token else {
                            print("token error")
                            return
                        }
                        print("token vlaido")
                        self.getSessionId(token: token) { [weak self] (result) in
                            guard let self = self else {
                                return
                            }
                            switch result {
                            case .success(let sessionId):
                                guard let sessionId = sessionId else {
                                    return
                                }
                                
                                self.defaults.set(sessionId, forKey: "sessionId")
                                self.profileService.getAccountDetails { (result) in
                                switch result {
                                    case .success(let account):
                                        guard
                                            let accountId = account?.id,
                                            let username = account?.username
                                        else {
                                            return
                                        }
                                        self.defaults.set(accountId, forKey: "accountId")
                                        self.defaults.set(username, forKey: "username")
                                        completion(.success(()))
                                    case .failure(let error):
                                        completion(.failure(error))
                                    }
                                }
                            case .failure(let error):
                                completion(.failure(error))
                            }
                        }
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    // swiftlint:enable cyclomatic_complexity

    func logout(completion: @escaping (Result<Void, Error>) -> Void) {
        self.defaults.set(false, forKey: "loginViewWasShown")
        self.defaults.removeObject(forKey: "session_id")
        
       
        completion(.success(()))
    }

    // MARK: - Private methods

    private func getToken(completion: @escaping (Result<String?, Error>) -> Void) {
        guard
            let url = URL(string: Constants.baseUrl + "/authentication/token/new")?
                .appending("api_key", value: Constants.movieApiKey)
        else {
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            guard let data = data else {
                return completion(.failure(NetworkError.noDataProvided))
            }
            do {
                let result = try decoder.decode(TokenResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(result.requestToken))
                }
            } catch {
                completion(.failure(NetworkError.failedToDecode))
            }
        }.resume()
    }

    private func validateToken(token: String,
                              login: String,
                              password: String,
                              completion: @escaping (Result<String?, Error>) -> Void) {
        let userData = [
            "username": login,
            "password": password,
            "request_token": token
        ]
        guard
            let httpBody = try? JSONSerialization.data(withJSONObject: userData, options: []),
            let url = URL(string: Constants.baseUrl + "/authentication/token/validate_with_login")?
                .appending("api_key", value: Constants.movieApiKey)
        else {
            return completion(.failure(NetworkError.invalidHttpBodyData))
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = httpBody
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            guard let data = data else {
                return completion(.failure(NetworkError.noDataProvided))
            }
            if let result = try? decoder.decode(TokenResponse.self, from: data) {
                DispatchQueue.main.async {
                    if let token = result.requestToken{
                        completion(.success(token))
                    }else{
                        completion(.failure(NetworkError.invalidCredentials))
                    }
                    
                }
            } else if let result = try? decoder.decode(StatusResponse.self, from: data) {
                guard let statusCode = result.statusCode, let statusMessage = result.statusMessage else {
                    return
                }
                let userInfo: [String: Any] = [NSLocalizedDescriptionKey: statusMessage]
                let error = NSError(domain: "", code: statusCode, userInfo: userInfo)
                completion(.failure(error))
            } else {
                completion(.failure(NetworkError.failedToDecode))
            }
        }.resume()
    }

    private func getSessionId(token: String, completion: @escaping (Result<String?, Error>) -> Void) {
        let userData = ["request_token": token]
        guard
            let httpBody = try? JSONSerialization.data(withJSONObject: userData, options: []),
            let url = URL(string: Constants.baseUrl + "/authentication/session/new")?
                .appending("api_key", value: Constants.movieApiKey)
        else {
            return completion(.failure(NetworkError.invalidHttpBodyData))
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = httpBody
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            guard let data = data else {
                return completion(.failure(NetworkError.noDataProvided))
            }
            do {
                let result = try decoder.decode(GetSessionIdResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(result.sessionId))
                }
            } catch {
                completion(.failure(NetworkError.failedToDecode))
            }
        }.resume()
    }
}

// MARK: - Private Structs

private struct TokenResponse: Codable {
    let success: Bool
    let expiresAt: String?
    let requestToken: String?
}

private struct GetSessionIdResponse: Codable {
    let success: Bool
    let sessionId: String?
}
