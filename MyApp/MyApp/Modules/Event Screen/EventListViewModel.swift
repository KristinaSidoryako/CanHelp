//
//  EventListViewModel.swift
//  MyApp
//
//  Created by Кристина Сидоряко on 20.07.2020.
//  Copyright © 2020 Кристина Сидоряко. All rights reserved.
//

import Foundation
import RxSwift

final class EventListViewModel {
  
  // MARK: Private Properties
  
  private let eventService: EventServiceProtocol
  
  // MARK: Initializers
  
  init(eventService: EventServiceProtocol = EventService()) {
    self.eventService = eventService
  }
  
  // MARK: Public Methods

  func fetchEventViewModels(selectCategory: String) -> Observable<[EventViewModel]> {
    return DispatchQueue.global(qos: .utility).sync { eventService.fetchEvents().map { $0.filter {$0.eventCategory == selectCategory}.map {EventViewModel(event: $0)} }
    }
  }
      
}
