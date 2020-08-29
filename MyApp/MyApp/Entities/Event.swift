//
//  Event.swift
//  MyApp
//
//  Created by Кристина Сидоряко on 20.07.2020.
//  Copyright © 2020 Кристина Сидоряко. All rights reserved.
//

import Foundation

struct Event: Decodable {
  let eventCategory: String
  let id: Int
  let iconImage: URL
  let mainTitle: String
  let mainText: String
  let date: Date
  let fond: String
  let adress: String
  let phone: [String]
  let icons: [String]
  let descriptionEvent: [String]
  let userIcon: [String]
  let likes: Int
}

