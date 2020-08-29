//
//  CategoryListViewModel.swift
//  MyApp
//
//  Created by Кристина Сидоряко on 20.07.2020.
//  Copyright © 2020 Кристина Сидоряко. All rights reserved.
//

import Foundation
import RxSwift

final class CategoryListViewModel {
  
  // MARK: Private Properties
  
  private let categoryService: CategoryServiceProtocol
  
  // MARK: Initializers
  
  init(categoryService: CategoryServiceProtocol = CategoryService()) {
    self.categoryService = categoryService
  }
  
  // MARK: Public Methods
  
  func fetchCategoryViewModels() -> Observable<[CategoryViewModel]> {
    return DispatchQueue.global(qos: .utility).sync {categoryService.fetchCategories().map { $0.map {
      CategoryViewModel(category: $0) } }
    }
  }
      
}
