//
//  Githup.swift
//  DevProfile
//
//  Created by eren on 5.03.2024.
//

import Foundation

struct GithubUser: Codable {
    let login: String
    let name: String
    let avatarUrl: String
    let followers: Int
    let following: Int
    let publicRepos: Int
    let publicGists: Int
    let bio: String?
}
