//
//  GithubManager.swift
//  DevProfile
//
//  Created by eren on 5.03.2024.
//

import Foundation

struct GithubManager {
    func getUser() async throws -> GithubUser {
        let endpoint = "https://api.github.com/users/erenoske"
        
        guard let url = URL(string: endpoint) else {
            throw GHError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw GHError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            // Fix the syntax
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(GithubUser.self, from: data)
        } catch {
            throw GHError.invalidData
        }
    }
}

enum GHError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}



