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
    
    func save<T: Codable>(_ object: T, forKey: DatabaseKeys, completion: @escaping (Bool) -> Void) where T: Equatable {
        
        var objects: [T] = []
        
        self.check(object, forKey: forKey) { result in
            if result {
                completion(false)
            }
        }
        
        self.fetch(forKey: forKey) { (result: Result<[T], Error>) in
            switch result {
            case .success(let response):
                objects = response
                objects.append(object)
            case .failure(_): break
            }
        }

        do {
            defaults.removeObject(forKey: forKey.rawValue)
            let data = try JSONEncoder().encode(objects)
            defaults.set(data, forKey: forKey.rawValue)
            defaults.synchronize()
            completion(true)
        } catch {
            completion(false)
        }
    }
    
    func fetch<T: Codable>(forKey: DatabaseKeys, completion: @escaping (Result<[T], Error>) -> Void) {
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
    
    
    func delete<T: Codable>(_ object: T, forKey: DatabaseKeys, completion: @escaping (Bool) -> Void) where T: Equatable {
        
        self.fetch(forKey: forKey) { [weak self] (result: Result<[T], Error>) in
            switch result {
            case .success(let response):
                var objects = response
                objects.remove(element: object)
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
    
    func check<T: Codable>(_ object: T, forKey: DatabaseKeys, completion: @escaping (Bool) -> Void) where T: Equatable {
        
        self.fetch(forKey: forKey) { (result: Result<[T], Error>) in
            switch result {
            case .success(let response):
                if response.contains(object) {
                    completion(true)
                } else {
                    completion(false)
                }
            case .failure(_):
                completion(false)
            }
        }
    }
    
    func deleteAll(forKey: DatabaseKeys) {
        defaults.removeObject(forKey: forKey.rawValue)
    }
}
