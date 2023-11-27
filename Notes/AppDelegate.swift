//
//  AppDelegate.swift
//  Notes
//
//  Created by Maksym on 23.11.2023.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        
        let tabbar = UITabBarController()
        
           
        let firstVC = UINavigationController(rootViewController: MainViewController())

           
        firstVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"),selectedImage: UIImage(systemName: "house.fill"))

        tabbar.viewControllers = [firstVC]

        window?.rootViewController = tabbar

        
        return true
        
    }
    

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError?{

                fatalError("Unresolved error, \((error as NSError).userInfo)")
            }
        })
        return container
    }()
    func saveContext(){
        let context = persistentContainer.viewContext
        if context.hasChanges{
            do{
                try context.save()
            }catch{
                let error = error as NSError
                fatalError("\(error)")
            }
        }
    }

}

