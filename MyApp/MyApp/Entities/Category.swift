//
//  Category.swift
//  MyApp
//
//  Created by Кристина Сидоряко on 20.07.2020.
//  Copyright © 2020 Кристина Сидоряко. All rights reserved.
//

import Foundation

struct Category: Decodable {
  let nameCategory: String
  let id: Int
  let image: URL
}
