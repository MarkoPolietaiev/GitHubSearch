//
//  RepoViewModel.swift
//  GitHubSearch
//
//  Created by Marko Polietaiev on 3/24/19.
//  Copyright © 2019 Marko Polietaiev. All rights reserved.
//

public class RepoViewModel {
    private let repo: Repo
    
    public init(repo: Repo) {
        self.repo = repo
    }
    
    public var name: String {
        return repo.name
    }
    
    public var description: String {
        return repo.repoDescription
    }
    
    public var link: String {
        return repo.link
    }
    
    public var popularity: Int {
        return repo.popularity
    }
}
