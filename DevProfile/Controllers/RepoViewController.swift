//
//  SecondViewController.swift
//  DevProfile
//
//  Created by eren on 5.03.2024.
//

import UIKit

class RepoViewController: UIViewController {
    
    
    private var titlesRepo: [GithupRepo] = [GithupRepo]()
    private var headerView: HeaderUIView?
    private var page = 1
    private var blurView: UIVisualEffectView!
    
    private let projectsTable: UITableView = {
        
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        table.showsVerticalScrollIndicator = false
        table.separatorStyle = .none
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        view.addSubview(projectsTable)
        
        projectsTable.delegate = self
        projectsTable.dataSource = self
        
        headerView = HeaderUIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 200))
        projectsTable.tableHeaderView = headerView
        
        projectsTable.frame = view.bounds
        
        getRepos(page: page)
        
        configureHeaderView()
    }
    
    private func configureHeaderView() {
        APICaller.shared.getGithupUser(with: UserData.shared.userName) { [weak self] result in
            switch result {
            case .success(let titles):
                self?.headerView?.configureHeader(with: HeaderViewModel(
                    login: titles.login,
                    name: titles.name,
                    avatarUrl: titles.avatarUrl
                ))
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func getRepos(page: Int) {
        APICaller.shared.getGithupUserRepo(with: UserData.shared.userName, page: page) { [weak self] result in
            switch result {
            case .success(let titles):
                self?.titlesRepo.append(contentsOf: titles)
                DispatchQueue.main.async {
                    self?.projectsTable.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}

extension RepoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        titlesRepo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as? CollectionViewTableViewCell else {
            return UITableViewCell()
        }
        
        let separatorView = UIView()
            separatorView.backgroundColor = UIColor.systemGray3
            cell.contentView.addSubview(separatorView)
            
            separatorView.translatesAutoresizingMaskIntoConstraints = false
            separatorView.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor).isActive = true
            separatorView.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor).isActive = true
            separatorView.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor).isActive = true
            separatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
            
        
        let title = titlesRepo[indexPath.row]
        cell.configure(with: title)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let title = titlesRepo[indexPath.row]
        
        guard let url = URL(string: title.svnUrl) else {
            return
        }
        
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            page += 1
            getRepos(page: page)
        }
    }
    
}
