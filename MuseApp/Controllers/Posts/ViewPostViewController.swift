//
//  ViewPostViewController.swift
//  MuseApp
//
//  Created by Anton Veldanov on 12/9/21.
//

import UIKit

class ViewPostViewController: UIViewController {

    private let post: BlogPost
    
    init(post: BlogPost){
        self.post = post
        super.init(nibName: nil, bundle: nil)
    }
    

    private let tableView: UITableView = {
        // title
        // header
        // body
        // Poster
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.register(PostHeaderTableViewCell.self, forCellReuseIdentifier: PostHeaderTableViewCell.identifier)

        
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }

    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension ViewPostViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        // 0: title
        // 1: image
        // 2: text
        
        switch index{
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = post.title
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PostHeaderTableViewCell.identifier, for: indexPath) as? PostHeaderTableViewCell else{
                fatalError()
            }
            cell.configureCell(with: .init(imageURL: post.headerImageURL))
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = post.text
            return cell
        default:
            fatalError()
        }
        
        return
        
    }
    
}
