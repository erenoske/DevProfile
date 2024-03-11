//
//  SecondViewController.swift
//  DevProfile
//
//  Created by eren on 5.03.2024.
//

import UIKit

class SecondViewController: UIViewController {
    
    private var titlesRepo: [GithupRepo] = [GithupRepo]()
    
    private let projectsTable: UITableView = {
        
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        view.addSubview(projectsTable)
        
        projectsTable.delegate = self
        projectsTable.dataSource = self
        
        projectsTable.frame = view.bounds
        
        APICaller.shared.getGithupUserRepo(with: "erenoske") { [weak self] result in
            switch result {
            case .success(let titles):
                self?.titlesRepo = titles
                DispatchQueue.main.async {
                    self?.projectsTable.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
}

extension SecondViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        titlesRepo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let title = titlesRepo[indexPath.row]
        cell.textLabel?.text = title.name
        cell.selectionStyle = .none
        return cell
    }
}


