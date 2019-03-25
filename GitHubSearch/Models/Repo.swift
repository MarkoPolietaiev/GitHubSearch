//
//  Repo.swift
//  GitHubSearch
//
//  Created by Marko Polietaiev on 3/25/19.
//  Copyright © 2019 Marko Polietaiev. All rights reserved.
//

import Foundation

public class Repo {
    
    public var name: String
    public var repoDescription: String
    public var popularity: Int
    public var link: String
    public var request: String?
    
    public init(name: String, description: String, popularity: Int, link: String, request: String?) {
        self.name = name
        self.repoDescription = description
        self.popularity = popularity
        self.link = link
        self.request = request
    }
}
