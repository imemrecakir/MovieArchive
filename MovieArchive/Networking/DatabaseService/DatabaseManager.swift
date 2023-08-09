//
//  DatabaseManager.swift
//  MovieArchive
//
//  Created by Emre Çakır on 9.08.2023.
//

import Foundation

final class DatabaseManager {
    static let shared = DatabaseManager()
    private init() {}
    private let defaults = UserDefaults.standard
    private let moviesKey = "Movies"
    
    func save<T: Codable>(_ object: T, forKey: DatabaseKeys, completion: @escaping (Bool) -> Void) {
        //        self.fetch(forKey: forKey) { result in
        //            switch result {
        //            case .success(var success):
        //                objects = success
        //                objects.append(object)
        //                defaults.removeObject(forKey: forKey.rawValue)
        //                do {
        //                    let data = try JSONEncoder().encode(objects)
        //                    defaults.set(data, forKey: forKey.rawValue)
        //                    defaults.synchronize()
        //                    completion(true)
        //                } catch {
        //                    completion(false)
        //                }
        //
        //            case .failure(let failure):
        //                do {
        //                    let objects: [T] = [object]
        //                    let data = try JSONEncoder().encode(objects)
        //                    defaults.set(data, forKey: forKey.rawValue)
        //                    defaults.synchronize()
        //                    completion(true)
        //                } catch {
        //                    completion(false)
        //                }
        //            }
        //        }
        
        self.fetch(forKey: forKey) { [weak self] (result: Result<[T], Error>) in
            switch result {
            case .success(let response):
                var objects = response
                objects.append(object)
                self?.defaults.removeObject(forKey: forKey.rawValue)
                do {
                    let data = try JSONEncoder().encode(objects)
                    self?.defaults.set(data, forKey: forKey.rawValue)
                    self?.defaults.synchronize()
                    completion(true)
                } catch {
                    completion(false)
                }
                completion(true)
            case .failure(_):
                completion(false)
            }
        }
    }
    
    func fetch<T: Codable>(forKey: DatabaseKeys, completion: @escaping (Result<[T], Error>) -> Void)
    {
        //        do {
        //            guard let data = defaults.data(forKey: forKey.rawValue) else {
        
        //                return
        //            }
        //            let decodedData = try JSONDecoder().decode(Array<T>.self, from: data)
        //
        //        } catch let error {
        //
        //        }
        
        if let data = UserDefaults.standard.data(forKey: forKey.rawValue) {
            do {
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode([T].self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(error))
            }
        } else {
            completion(.failure(NSError(domain: "No data for key \(forKey)", code: 0)))
        }
    }
}
