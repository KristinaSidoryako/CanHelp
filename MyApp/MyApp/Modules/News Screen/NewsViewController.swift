//
//  NewsViewController.swift
//  MyApp
//
//  Created by Кристина Сидоряко on 13.07.2020.
//  Copyright © 2020 Кристина Сидоряко. All rights reserved.
//

import UIKit

protocol NewsDisplayLogic: class {
  func displayNews(newsTitle: String)
}

class NewsViewController: UIViewController {
  
  // MARK: IBOutlets

  @IBOutlet weak var mainLabel: UILabel!
  @IBOutlet weak var mainButton: UIButton!
  
  // MARK: Pubclic Properties
  
  var interactor: NewsBuisnessLogic?
  
  // MARK: Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setup()
  }
  
  // MARK: Private Methods
  
  private func setup() {
    let interactor = NewsViewInteractor()
    let presenter = NewsViewPresenter()
    self.interactor = interactor
    interactor.presenter = presenter
    presenter.viewController = self
  }

  // MARK: IBActions
  
  @IBAction func setTitleLabel(_ sender: UIButton) {
    interactor?.didTapTitleButton()
  }
  
}

// MARK: NewsDisplayLogic

extension NewsViewController: NewsDisplayLogic {
  
  func displayNews(newsTitle: String) {
    mainLabel.text = newsTitle
  }
  
}
