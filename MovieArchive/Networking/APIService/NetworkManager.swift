//
//  NetworkManager.swift
//  MovieArchive
//
//  Created by Emre Çakır on 26.07.2023.
//

import Foundation
import Alamofire

final class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    private func request<T: Codable>(_ endpoint: Endpoint, completion: @escaping (Result<T, Error>) -> Void) {

        endpoint.request().response { response in
            if let error = response.error {
                completion(.failure(error))
            }
            
            guard let data = response.data else {
                completion(.failure(NSError(domain: "Invalid Response Data", code: 0)))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch let error {
                completion(.failure(error))
            }
        }
    }
}
