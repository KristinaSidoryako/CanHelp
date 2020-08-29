//
//  CategoryService.swift
//  MyApp
//
//  Created by Кристина Сидоряко on 20.07.2020.
//  Copyright © 2020 Кристина Сидоряко. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import CoreData

protocol CategoryServiceProtocol {
  func fetchCategories() -> Observable<[Category]>
}

class CategoryService {
  
  // MARK: Private Methods
  
  private func getCategoryFromContainer() -> [NSManagedObject]? {
    let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    let managedContext: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
    
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CategoryEntity")
    
    return try? managedContext.fetch(fetchRequest) as? [NSManagedObject]
  }
  
  private func mapping(managedObject: [NSManagedObject]) -> [Category] {
    var categories = [Category]()
    
    for elem in managedObject {
      let category = Category(nameCategory: elem.value(forKey: "nameCategory") as! String, id: elem.value(forKey: "id") as! Int, image: elem.value(forKey: "image") as! URL)
      categories.append(category)
    }
    
    let newCategories = categories.sorted(by: { $0.id < $1.id })
    
    return newCategories
  }
  
}

// MARK: CategoryServiceProtocol

extension CategoryService: CategoryServiceProtocol {
  
  func fetchCategories() -> Observable<[Category]> {
    return Observable.create { observer -> Disposable in
      
      var error: NSError?
  
      if let results = self.getCategoryFromContainer() {
        observer.onNext(self.mapping(managedObject: results))
      } else {
        print("Could not fetch \(String(describing: error)), \(error!.userInfo)")
        observer.onError(error!)
      }
      
      return Disposables.create { }
    }
  }
  
}
