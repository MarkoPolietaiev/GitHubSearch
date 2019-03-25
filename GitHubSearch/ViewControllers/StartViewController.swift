//
//  ViewController.swift
//  GitHubSearch
//
//  Created by Marko Polietaiev on 3/23/19.
//  Copyright © 2019 Marko Polietaiev. All rights reserved.
//

import UIKit
import DropDown
import GithubAPI
import CoreData

class StartViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var resultsTableView: UITableView!
    
    var model: Repo?
    var oldRequests = [String]()
    var repos: [Repo] = []
    var fetchedRequests: [NSManagedObject] = []
    var dropButton = DropDown()
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getReq()
        initDropButton()
        setupDataSource()
        configSearchController()
        definesPresentationContext = true
    }
    
    func setupDataSource() {
        resultsTableView.register(R.nib.repoItemTableViewCell)
        resultsTableView.reloadData()
    }
    
    func configSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Repos"
        navigationItem.searchController = searchController
    }
    
    func initDropButton() {
        dropButton.anchorView = searchBar
        dropButton.bottomOffset = CGPoint(x: 0, y:(dropButton.anchorView?.plainView.bounds.height)!)
        dropButton.backgroundColor = .white
        dropButton.direction = .bottom
        dropButton.dataSource = oldRequests
        dropButton.selectionAction = { [unowned self] (index: Int, item: String) in
            self.repos = []
            self.searchRepo(searchValue: item)
            self.searchBar.text = item
        }
    }
    
    //MARK: Entities
    
    //Request
    
    func saveReq(name: String) {
        let context = (UIApplication.shared.delegate as? AppDelegate)!.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Request", in: context)
        let newEntity = NSManagedObject(entity: entity!, insertInto: context)
        
        newEntity.setValue(name, forKey: "name")
        
        do {
            if !someEntityExists(entityName: "Request", name: name) {
                try context.save()
            } else {
                print("Already Exists")
            }
        } catch {
            print("saving failed")
        }
    }
    
    func getReq() {
        let context = (UIApplication.shared.delegate as? AppDelegate)!.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Request")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in (result as? [NSManagedObject])! {
                if !oldRequests.contains((data.value(forKey: "name") as? String)!) {
                    oldRequests.append((data.value(forKey: "name") as? String)!)
                }
            }
        } catch {
            print("Getting failed")
        }
    }
    
    //MARK: Repos
    func getRepoByRequest(entityName: String, requset: String) -> [NSManagedObject] {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "request == %@", requset)
        
        var items: [NSManagedObject] = []
        
        let context = (UIApplication.shared.delegate as? AppDelegate)!.persistentContainer.viewContext
        do {
            items = try context.fetch(fetchRequest)
        } catch {
            print("error executing fetch request: \(error)")
        }
        
        return items
    }
    
    func saveRepo(name: String, description: String, popularity: Int, link: String, request: String) {
        let context = (UIApplication.shared.delegate as? AppDelegate)!.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Repo", in: context)
        let newEntity = NSManagedObject(entity: entity!, insertInto: context)
        
        newEntity.setValue(name, forKey: "name")
        newEntity.setValue(description, forKey: "repoDescription")
        newEntity.setValue(popularity, forKey: "popularity")
        newEntity.setValue(link, forKey: "link")
        newEntity.setValue(request, forKey: "request")
        
        do {
            try context.save()
        } catch {
            print("saving failed")
        }
    }
    
    func searchRepo(searchValue: String) {
        if oldRequests.contains(searchValue) {
            let result = getRepoByRequest(entityName: "Repo", requset: searchValue)
            for repo in (result as [NSManagedObject]) {
                if self.repos.count < 30 {
                    let newRepo = Repo(name: (repo.value(forKey: "name") as? String)!, description: (repo.value(forKey: "repoDescription") as? String)!, popularity: (repo.value(forKey: "popularity") as? Int)!, link: (repo.value(forKey: "link") as? String)!, request: (repo.value(forKey: "request") as? String)!)
                    self.repos.append(newRepo)
                    self.repos.sort(by: {$0.popularity > $1.popularity})
                    DispatchQueue.main.async {
                        self.resultsTableView.reloadData()
                    }
                }
            }
        } else {
            SearchAPI().searchRepositories(q: searchValue, page: 1, per_page: 100) { (response, error) in
                if let response = response {
                    for repo in response.items! {
                        if self.repos.count < 30 {
                            if let name = repo.fullName, let description = repo.descriptionField, let popularity = repo.stargazersCount, let link = repo.htmlUrl {
                                let newRepo = Repo.init(name: name, description: description, popularity: popularity, link: link, request: searchValue)
                                self.repos.append(newRepo)
                                self.repos.sort(by: {$0.popularity > $1.popularity})
                                DispatchQueue.main.async {
                                    self.saveRepo(name: name, description: description, popularity: popularity, link: link, request: searchValue)
                                    self.resultsTableView.reloadData()
                                }
                            }
                        }
                    }
                } else {
                    print(error ?? "")
                }
            }
        }
    }
    
    func someEntityExists(entityName: String, name: String) -> Bool {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        
        var results: [NSManagedObject] = []
        
        let context = (UIApplication.shared.delegate as? AppDelegate)!.persistentContainer.viewContext
        do {
            results = try context.fetch(fetchRequest)
        } catch {
            print("error executing fetch request: \(error)")
        }
        
        return results.count > 0
    }
    
    //MARK: SearchBar+DropDown
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        oldRequests = searchText.isEmpty ? oldRequests : oldRequests.filter({ (req) -> Bool in
            req.range(of: searchText, options: .caseInsensitive) != nil
            })
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        getReq()
        dropButton.dataSource = oldRequests
        dropButton.show()
        searchBar.setShowsCancelButton(true, animated: true)
        for ob: UIView in ((searchBar.subviews[0])).subviews {
            if let z = ob as? UIButton {
                let btn: UIButton = z
                btn.setTitleColor(.white, for: .normal)
            }
        }
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.text = ""
        dropButton.hide()
    }
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        repos = []
        searchRepo(searchValue: searchBar.text!)
        saveReq(name: searchBar.text!)
        dropButton.hide()
    }
}

extension StartViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        guard let url = URL(string: repos[row].link) else { return }
        UIApplication.shared.open(url)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

extension StartViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let model: Repo = repos[row]
        let cell = resultsTableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.repoItemTableViewCell, for: indexPath)!
        cell.setupWithModel(model, id: row + 1)
        if let popularity = cell.popularityLabel.text {
            if Int(popularity)! > 999 {
                cell.popularityLabel.text = "1000+"
            }
        }
        return cell
    }
    
}

extension StartViewController: UISearchBarDelegate {
    
}

extension StartViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}
