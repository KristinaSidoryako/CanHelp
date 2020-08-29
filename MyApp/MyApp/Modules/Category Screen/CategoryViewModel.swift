//
//  CategoryViewModel.swift
//  MyApp
//
//  Created by Кристина Сидоряко on 20.07.2020.
//  Copyright © 2020 Кристина Сидоряко. All rights reserved.
//

import Foundation

class CategoryViewModel {
  
  // MARK: Public Properties
  
  var displayCategoryName: String {
    return category.nameCategory
  }
  
  var displayId: Int {
    return category.id
  }
  
  var displayImage: URL {
    return category.image
  }
  
  // MARK: Private Properties
   
  private let category: Category
  
  // MARK: Initializers
  
  init(category: Category) {
    self.category = category
  }
  
}
