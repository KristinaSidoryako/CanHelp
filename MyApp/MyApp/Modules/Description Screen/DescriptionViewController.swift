//
//  DescriptionViewController.swift
//  MyApp
//
//  Created by Кристина Сидоряко on 21.07.2020.
//  Copyright © 2020 Кристина Сидоряко. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class DescriptionViewController: UIViewController {
  
  // MARK: IBOutlets
  
  @IBOutlet weak var descriptionTableView: UITableView!
  @IBOutlet weak var iconFirst: UIImageView!
  @IBOutlet weak var iconSecond: UIImageView!
  @IBOutlet weak var iconThird: UIImageView!
  @IBOutlet weak var iconFourth: UIImageView!
  @IBOutlet weak var iconFifth: UIImageView!
  @IBOutlet weak var likes: UILabel!
  
  // MARK: Public Properties
  
  let disposeBag = DisposeBag()
  var currentIdEventDescription: Int?
  var selectedCategoryDescription: String?
  
  // MARK: Private Properties
  
  private var viewModel: EventListViewModel!
  
  // MARK: Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    viewModel = EventListViewModel()
    
    let help = self.navigationController as? DescriptionNavigationController
    currentIdEventDescription = help?.currentId
    selectedCategoryDescription = help?.currentCategory
    navigationItem.title = help?.titleBar
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
    
    descriptionTableView.dataSource = nil

    viewModel.fetchEventViewModels(selectCategory: selectedCategoryDescription!)
      .map { $0.filter {$0.displayId == self.currentIdEventDescription} }
      .bind(to: descriptionTableView
        .rx
        .items(cellIdentifier: "\(DescriptionTableViewCell.self)",
               cellType: DescriptionTableViewCell.self)) { [unowned self] index, viewModel, cell in
          cell.configure(viewModel: viewModel)
          self.iconFirst.image = UIImage(named: viewModel.displayUserIcon[0])
          self.iconSecond.image = UIImage(named: viewModel.displayUserIcon[1])
          self.iconThird.image = UIImage(named: viewModel.displayUserIcon[2])
          self.iconFourth.image = UIImage(named: viewModel.displayUserIcon[3])
          self.iconFifth.image = UIImage(named: viewModel.displayUserIcon[4])
          self.likes.text = "+\(viewModel.displayLikes)"
    }
    .disposed(by: disposeBag)
  }
  
  // MARK: IBActions
  
  @IBAction func back(_ sender: UIBarButtonItem) {
    dismiss(animated: true, completion: nil)
  }

}



