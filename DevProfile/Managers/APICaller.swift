//
//  APICaller.swift
//  DevProfile
//
//  Created by eren on 10.03.2024.
//

import Foundation

struct Constants {
    static let gitBaseURL = "https://api.github.com/"
}

enum APIError: Error {
    case failedTogetData
}

class APICaller {
    static let shared = APICaller()
    
    func getGithupUser(with user: String, completion: @escaping (Result<GithubUser, Error>) -> Void) {
        guard let url = URL(string: "\(Constants.gitBaseURL)users/\(user)") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let result = try decoder.decode(GithubUser.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(APIError.failedTogetData))
            }
        }
        
        task.resume()
        
    }
    
    func getGithupUserRepo(with user: String, page: Int, completion: @escaping (Result<[GithupRepo], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.gitBaseURL)users/\(user)/repos?page=\(page)") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let results = try decoder.decode([GithupRepo].self, from: data)
                completion(.success(results))
            } catch {
                completion(.failure(APIError.failedTogetData))
            }
        }
        
        task.resume()
    }
    
    func getGithupUserStarred(with user: String, page: Int, completion: @escaping (Result<[GithupRepo], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.gitBaseURL)users/\(user)/starred?page=\(page)") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let results = try decoder.decode([GithupRepo].self, from: data)
                completion(.success(results))
            } catch {
                completion(.failure(APIError.failedTogetData))
            }
        }
        
        task.resume()
    }
}
