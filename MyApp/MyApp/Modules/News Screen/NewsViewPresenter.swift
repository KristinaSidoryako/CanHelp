//
//  NewsViewPresenter.swift
//  MyApp
//
//  Created by Кристина Сидоряко on 18.08.2020.
//  Copyright © 2020 Кристина Сидоряко. All rights reserved.
//

import Foundation

protocol NewsPresentationLogic: class {
  func presentNews(response: [String])
}

class NewsViewPresenter {
  
  // MARK: Public Properties
  
  weak var viewController: NewsDisplayLogic?
  
}

// MARK: NewsPresentationLogic

extension NewsViewPresenter: NewsPresentationLogic {
  
  func presentNews(response: [String]) {
    let number = Int.random(in: 0...response.count - 1)
    viewController?.displayNews(newsTitle: response[number])
  }
  
}
