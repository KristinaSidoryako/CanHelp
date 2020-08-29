//
//  EventService.swift
//  MyApp
//
//  Created by Кристина Сидоряко on 20.07.2020.
//  Copyright © 2020 Кристина Сидоряко. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import CoreData

protocol EventServiceProtocol {
  func fetchEvents() -> Observable<[Event]>
}

class EventService {
  
  // MARK: Private Methods
  
  private func getEventFromContainer() -> [NSManagedObject]? {
    let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    let managedContext: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
    
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "EventEntity")
    
    return try? managedContext.fetch(fetchRequest) as? [NSManagedObject] 
  }
  
  private func mapping(managedObject: [NSManagedObject]) -> [Event] {
    var events = [Event]()
    
    for element in managedObject {
      let dataPhone = element.value(forKey: "phone") as! NSData
      let unarchivePhone = NSKeyedUnarchiver.unarchiveObject(with: dataPhone as Data)
      let arrayPhone = unarchivePhone as! [String]
      
      let dataIcons = element.value(forKey: "icons") as! NSData
      let unarchiveIcons = NSKeyedUnarchiver.unarchiveObject(with: dataIcons as Data)
      let arrayIcons = unarchiveIcons as! [String]
      
      let dataDescriptionEvent = element.value(forKey: "descriptionEvent") as! NSData
      let unarchiveDescriptionEvent = NSKeyedUnarchiver.unarchiveObject(with: dataDescriptionEvent as Data)
      let arrayDescriptionEvent = unarchiveDescriptionEvent as! [String]
      
      let dataUserIcon = element.value(forKey: "userIcon") as! NSData
      let unarchiveUserIcon = NSKeyedUnarchiver.unarchiveObject(with: dataUserIcon as Data)
      let arrayUserIcon = unarchiveUserIcon as! [String]
      
      let event = Event(eventCategory: element.value(forKey: "eventCategory") as! String,
                        id: element.value(forKey: "id") as! Int,
                        iconImage: element.value(forKey: "iconImage") as! URL,
                        mainTitle: element.value(forKey: "mainTitle") as! String,
                        mainText: element.value(forKey: "mainText") as! String,
                        date: element.value(forKey: "date") as! Date,
                        fond: element.value(forKey: "fond") as! String,
                        adress: element.value(forKey: "adress") as! String,
                        phone: arrayPhone, icons: arrayIcons, descriptionEvent: arrayDescriptionEvent, userIcon: arrayUserIcon,
                        likes: element.value(forKey: "likes") as! Int)
      events.append(event)
    }
    
    let newEvents = events.sorted(by: { $0.id < $1.id })
    
    return newEvents
  }
  
}

// MARK: EventServiceProtocol

extension EventService: EventServiceProtocol {
  
  func fetchEvents() -> Observable<[Event]> {
    return Observable.create { observer -> Disposable in
      
      var error: NSError?
      
      if let results = self.getEventFromContainer() {
        observer.onNext(self.mapping(managedObject: results))
      } else {
        print("Could not fetch \(String(describing: error)), \(error!.userInfo)")
        observer.onError(error!)
      }
      
      return Disposables.create { }
    }
  }
  
}
