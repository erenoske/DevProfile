//
//  GithupRepo.swift
//  DevProfile
//
//  Created by eren on 11.03.2024.
//

import Foundation

struct GithupRepo: Codable {
    let name: String
    let description: String?
    let svnUrl: String
    let owner: Owner
    let stargazersCount: Int
}

struct Owner: Codable {
    let htmlUrl: String
}
