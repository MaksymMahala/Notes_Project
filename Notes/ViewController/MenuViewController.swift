//
//  MenuViewController.swift
//  Notes
//
//  Created by Maksym on 25.11.2023.
//

import UIKit
import SnapKit

class MenuViewController: UIViewController {
    var lineMenu = ["Account", "Email", "Scheme", "Version"]
    var image = ["heart", "person", "circle", "house"]
    
    
    var tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "menu")
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        title = "Account"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus.circle.fill"), style: .plain, target: self, action: #selector(addImage))
        
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
    }
    @objc func addImage(){
        
    }
}
extension MenuViewController: UITableViewDelegate, UITableViewDataSource{
    
    func setupUI(){
        // Do any additional setup after loading the view.
        navigationController?.navigationBar.prefersLargeTitles = true
        let appearence = UINavigationBarAppearance()
        appearence.configureWithOpaqueBackground()
        
        appearence.backgroundColor = .systemBlue
        appearence.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        appearence.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.black]
        
        self.navigationController?.navigationBar.standardAppearance = appearence
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearence
        self.navigationController?.navigationBar.compactAppearance = appearence
        
        self.navigationController?.navigationBar.tintColor = .white
    
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lineMenu.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menu", for: indexPath)
        let cellMenu = lineMenu[indexPath.row]
        let cellImage = image[indexPath.row]
        cell.imageView?.image = UIImage(systemName: cellImage)
        cell.textLabel?.text = cellMenu
        cell.textLabel?.textColor = .black
        cell.accessoryType = .disclosureIndicator
       return cell
   }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0;//Choose your custom row height
    }
}
