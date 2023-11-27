//
//  ViewLoginController.swift
//  Notes
//
//  Created by Maksym on 23.11.2023.
//

import UIKit
import SnapKit
import CoreData


class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var model = [CodeItem]()
    let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "myCell")
        return table
    }()
    
    var containerView = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "filemenu.and.cursorarrow"), style: .done, target: self, action: #selector(didTapButton))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(add))
        setupUI()
        containerSetup()
        
        getAllItems()
       
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return model.count
     }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        let dataCell = model[indexPath.item]
        cell.textLabel?.text = dataCell.name
        cell.textLabel?.textColor = .white
        cell.backgroundColor = .black
        cell.accessoryType = .disclosureIndicator
        cell.layer.cornerRadius = 10
        cell.layer.borderWidth = 0.4
        cell.layer.borderColor = CGColor(gray: 1, alpha: 1)
        return cell
    }
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = model[indexPath.row]
        let sheet = UIAlertController(title: "Edit or Delete", message: "Are you sure?", preferredStyle: .actionSheet)
        sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        sheet.addAction(UIAlertAction(title: "Edit", style: .default, handler: { _ in
            let alert = UIAlertController(title: "Edit item", message: "Edit your item", preferredStyle: .alert)
            alert.addTextField(configurationHandler: nil)
            alert.textFields?.first?.text = item.name
            alert.addAction(UIAlertAction(title: "Save", style: .cancel, handler: { [weak self] _ in
                guard let field = alert.textFields?.first, let newName = field.text, !newName.isEmpty else{
                    return
                }
                self?.updateitem(item: item, newName: newName)
            }))
           
            self.present(alert, animated: true)
        }))
        sheet.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { [weak self] _ in
            self?.deleteItems(item: item)
        }))
        
        present(sheet, animated: true)
        
    }
    @objc func didTapButton(){
        let vc = MenuViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc func add(){
        let alert = UIAlertController(title: "Create item", message: "Write your item", preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        alert.addAction(UIAlertAction(title: "Sumbit", style: .cancel, handler: { [weak self] _ in
            guard let field = alert.textFields?.first, let text = field.text, !text.isEmpty else{
                return
            }
            self?.createItemsName(name: text)
        }))
        present(alert, animated: true)
    }
}
extension MainViewController{
    func setupUI(){
        navigationController?.navigationBar.prefersLargeTitles = true
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .black
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance

        view.addSubview(tableView)
        tableView.backgroundColor = .black
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self

    }
    func containerSetup(){
        containerView.backgroundColor = .black
        view.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func getAllItems(){
        do{
            model = try context.fetch(CodeItem.fetchRequest())
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }catch{
            //error
        }
    }
    func createItemsName(name: String){
        let newItem = CodeItem(context: context)
        newItem.id = UUID()
        newItem.name = name
        newItem.code = "mew"
        
        do{
            try context.save()
            getAllItems()
        }catch{
            //error
        }
    }
    func deleteItems(item: CodeItem){
        context.delete(item)
        do{
            try context.save()
            getAllItems()
        }
        catch{
            print(error.localizedDescription.description)
        }
    }
    func updateitem(item: CodeItem, newName: String){
        item.name = newName
    
        do{
            try context.save()
            getAllItems()
        }catch{
            //error
        }
    
    }
}
