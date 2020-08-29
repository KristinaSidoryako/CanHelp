//
//  EventViewModel.swift
//  MyApp
//
//  Created by Кристина Сидоряко on 20.07.2020.
//  Copyright © 2020 Кристина Сидоряко. All rights reserved.
//

import Foundation

class EventViewModel {
  
  // MARK: Private Properties
  
  private let event: Event
  
  // MARK: Public Properties
  
  var displayCategoryEvent: String {
    return event.eventCategory
  }
  
  var displayId: Int {
    return event.id
  }
  
  var displayIconImage: URL {
    return event.iconImage
  }
  
  var displayMainTitle: String {
    return event.mainTitle
  }
  
  var displayMainText: String {
    return event.mainText
  }
  
  var displayDate: Date {
    return event.date
  }
  
  var displayDateText: String {
    let currentDate = Date()
    let dateDiff = Calendar.current.dateComponents([.day], from: currentDate, to: displayDate).day
    
    let dateCurrentFormatter = DateFormatter()
    dateCurrentFormatter.dateStyle = .short
    let dateCurrentShort = dateCurrentFormatter.string(from: currentDate as Date)
    let arrayCurrentDate = dateCurrentShort.split(separator: "/")
    
    let dateEventFormatter = DateFormatter()
    dateEventFormatter.dateStyle = .short
    let dateEventShort = dateEventFormatter.string(from: displayDate as Date)
    let arrayEventDate = dateEventShort.split(separator: "/")
    
    var currentMonth = arrayCurrentDate[0], currentDay = arrayCurrentDate[1]
    var eventMonth = arrayEventDate[0], eventDay = arrayEventDate[1]
    
    if arrayCurrentDate[0].count < 2 {
      currentMonth = "0" + arrayCurrentDate[0]
    }
    
    if arrayCurrentDate[1].count < 2 {
      currentDay = "0" + arrayCurrentDate[1]
    }
    
    if arrayEventDate[0].count < 2 {
      eventMonth = "0" + arrayEventDate[0]
    }
    
    if arrayEventDate[1].count < 2 {
      eventDay = "0" + arrayEventDate[1]
    }
 
    let endPartString = "(\(currentDay).\(currentMonth) - \(eventDay).\(eventMonth))"
    
    switch dateDiff! {
    case let x where x % 10 == 1 && x % 100 != 11:
      return "Остался \(dateDiff!) день \(endPartString)"
    case let x where x % 10 > 1 && x % 10 < 5:
      return "Осталось \(dateDiff!) дня \(endPartString)"
    default:
      return "Осталось \(dateDiff!) дней \(endPartString)"
    }
  }
  
  var displayFond: String {
    return event.fond
  }
  
  var displayAdress: String {
    return event.adress
  }
  
  var displayPhone: [String] {
    return event.phone
  }
  
  var displayIcons: [String] {
    return event.icons
  }
  
  var displayDescription: [String] {
    return event.descriptionEvent
  }
  
  var displayUserIcon: [String] {
    return event.userIcon
  }
  
  var displayLikes: Int {
    return event.likes
  }
  
  // MARK: Initializers
  
  init(event: Event) {
    self.event = event
  }
  
}
