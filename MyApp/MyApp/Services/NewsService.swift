//
//  NewsService.swift
//  MyApp
//
//  Created by Кристина Сидоряко on 18.08.2020.
//  Copyright © 2020 Кристина Сидоряко. All rights reserved.
//

import Foundation

protocol NewsServiceProtocol {
  func fetchNews() -> [String]?
}

class NewsService {
}

// MARK: NewsServiceProtocol

extension NewsService: NewsServiceProtocol {
  
  func fetchNews() -> [String]? {
    guard let path = Bundle.main.path(forResource: "news", ofType: "json") else { return nil }
    
    let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
    let news = try? JSONDecoder().decode([String].self, from: data!)
      
    return news
  }
  
}
