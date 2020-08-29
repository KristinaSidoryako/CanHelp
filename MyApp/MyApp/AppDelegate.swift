//
//  AppDelegate.swift
//  MyApp
//
//  Created by Кристина Сидоряко on 10.07.2020.
//  Copyright © 2020 Кристина Сидоряко. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // customize navigation bar
    setupNavigationBar()
      
    // customize tab bar
    setupTabBar()
    
    DispatchQueue.global().async {
      self.recordCategoryToContainer()
      self.recordEventToContainer()
    }
 
    return true
  }

  // MARK: UISceneSession Lifecycle

  func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
    return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
  }

  func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
  }
  
  // MARK: - Core Data stack

  lazy var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "MyApp")
    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    })
    return container
  }()

  // MARK: - Core Data Saving support

  func saveContext () {
    let context = persistentContainer.viewContext
    if context.hasChanges {
      do {
        try context.save()
      } catch {
        let nserror = error as NSError
        fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
      }
    }
  }
  
  // MARK: Private Methods
  
  private func getCategoryFromJson() -> [Category]? {
    guard let path = Bundle.main.path(forResource: "category", ofType: "json") else { return nil }
    
    let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
    let categories = try? JSONDecoder().decode([Category].self, from: data!)
      
    return categories
  }
  
  private func recordCategoryToContainer() {
    let managedContext: NSManagedObjectContext = persistentContainer.viewContext

    do {
      try managedContext.execute(NSBatchDeleteRequest(fetchRequest: NSFetchRequest(entityName: "CategoryEntity")))
    } catch let error as NSError {
      print(error.localizedDescription)
    }
    
    saveContext()
    
    let entity = NSEntityDescription.entity(forEntityName: "CategoryEntity", in: managedContext)
    
    if let categories = getCategoryFromJson() {
      for elem in categories {
        let category = NSManagedObject(entity: entity!, insertInto: managedContext)
        category.setValue(elem.nameCategory, forKey: "nameCategory")
        category.setValue(elem.id, forKey: "id")
        category.setValue(elem.image, forKey: "image")
        }
    } else {
      print("Category data is not exist")
    }
    
    saveContext()
  }
  
  private func getEventFromJson() -> [Event]? {
    guard let path = Bundle.main.path(forResource: "event", ofType: "json") else { return nil }
    
    let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601
    let events = try? decoder.decode([Event].self, from: data!)
  
    return events
  }
  
  private func recordEventToContainer() {
    let managedContext: NSManagedObjectContext = persistentContainer.viewContext

    do {
      try managedContext.execute(NSBatchDeleteRequest(fetchRequest: NSFetchRequest(entityName: "EventEntity")))
    } catch let error as NSError {
      print(error.localizedDescription)
    }
    
    saveContext()
    
    let entity = NSEntityDescription.entity(forEntityName: "EventEntity", in: managedContext)
    
    if let events = getEventFromJson() {
      for elem in events {
        let dataPhone = try? NSKeyedArchiver.archivedData(withRootObject: elem.phone, requiringSecureCoding: false)
        let dataIcons = try? NSKeyedArchiver.archivedData(withRootObject: elem.icons, requiringSecureCoding: false)
        let dataDescriptionEvent = try? NSKeyedArchiver.archivedData(withRootObject: elem.descriptionEvent, requiringSecureCoding: false)
        let dataUserIcon = try? NSKeyedArchiver.archivedData(withRootObject: elem.userIcon, requiringSecureCoding: false)
        
        let event = NSManagedObject(entity: entity!, insertInto: managedContext)
        event.setValue(elem.eventCategory, forKey: "eventCategory")
        event.setValue(elem.id, forKey: "id")
        event.setValue(elem.iconImage, forKey: "iconImage")
        event.setValue(elem.mainTitle, forKey: "mainTitle")
        event.setValue(elem.mainText, forKey: "mainText")
        event.setValue(elem.date, forKey: "date")
        event.setValue(elem.fond, forKey: "fond")
        event.setValue(elem.adress, forKey: "adress")
        event.setValue(dataPhone, forKey: "phone")
        event.setValue(dataIcons, forKey: "icons")
        event.setValue(dataDescriptionEvent, forKey: "descriptionEvent")
        event.setValue(dataUserIcon, forKey: "userIcon")
        event.setValue(elem.likes, forKey: "likes")
        }
    } else {
      print("Event data is not exist")
    }
    
    saveContext()
  }
  
  private func setupNavigationBar() {
    let navigationBarAppearace = UINavigationBar.appearance()
    navigationBarAppearace.barTintColor = .leafColor
    navigationBarAppearace.tintColor = .white
    if let fontNavigationTitle = UIFont(name: "OfficinaSansExtraBoldC", size: 21) {
      navigationBarAppearace.titleTextAttributes = [NSAttributedString.Key.font: fontNavigationTitle, NSAttributedString.Key.foregroundColor: UIColor.white]
    } else {
      print("not exist needed font")
    }
  }
  
  private func setupTabBar() {
    UITabBar.appearance().barTintColor = .white
    UITabBar.appearance().tintColor = .leafColor
  }
  
}


