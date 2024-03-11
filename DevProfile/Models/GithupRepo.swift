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
    let owner: Owner
}

struct Owner: Codable {
    let htmlUrl: String
}
