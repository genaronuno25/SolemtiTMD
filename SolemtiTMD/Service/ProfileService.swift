//
//  ProfileService.swift
//  SolemtiTMD
//
//  Created by gerardo.nuno on 10/04/22.
//


import Foundation

final class ProfileService {

    // MARK: - Properties

    private let guestAccount = Account(id: nil,
                                       name: "Guest",
                                       username: "Guest",
                                       includeAdult: true)

    // MARK: - Methods

    func getAccountDetails(completion: @escaping (Result<Account?, Error>) -> Void) {
        guard let sessionId = AuthorizationService.sessionId else {
            completion(.success(guestAccount))
            return
        }
        guard
            let url = URL(string: Constants.baseUrl + "/account")?
                .appending("api_key", value: Constants.movieApiKey)?
                .appending("session_id", value: sessionId)
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
                let result = try decoder.decode(Account.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(result))
                }
            } catch {
                completion(.failure(NetworkError.failedToDecode))
            }
        }.resume()
    }
}
