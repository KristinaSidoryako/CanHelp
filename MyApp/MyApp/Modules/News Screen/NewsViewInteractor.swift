//
//  NewsViewInteractor.swift
//  MyApp
//
//  Created by Кристина Сидоряко on 18.08.2020.
//  Copyright © 2020 Кристина Сидоряко. All rights reserved.
//

import Foundation

protocol NewsBuisnessLogic: class {
  func didTapTitleButton()
}

class NewsViewInteractor {
  
  // MARK: Public Properties
  
  var presenter: NewsPresentationLogic?
  
  let newsService: NewsServiceProtocol = NewsService()
  
  // MARK: Private Methods
  
  private func fetchNews() {
    if let response = newsService.fetchNews() {
      presenter?.presentNews(response: response)
    } else {
      print("Data isn't exist")
    }
  }

}

// MARK: NewsBuisnessLogic

extension NewsViewInteractor: NewsBuisnessLogic {
  
  func didTapTitleButton() {
    fetchNews()
  }
  
}
