//
//  CategoryViewController.swift
//  MyApp
//
//  Created by Кристина Сидоряко on 10.07.2020.
//  Copyright © 2020 Кристина Сидоряко. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CategoryViewController: UIViewController {
  
  // MARK: IBOutlets
  
  @IBOutlet weak var collectionView: UICollectionView!
  
  // MARK: Public Properties

  var selectedCategory: String? 
  
  var disposeBag = DisposeBag()

  // MARK: Private Properties
  
  private let countCells = 2
  private let offset: CGFloat = 9.0
  private let segueIdentifierEvent = "segueScreenEvents"
  
  private var viewModel: CategoryListViewModel!
  
  // MARK: Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    viewModel = CategoryListViewModel()
      
    // register cell
    collectionView.register(UINib(nibName: "\(SectionCollectionViewCell.self)", bundle: nil), forCellWithReuseIdentifier: "\(SectionCollectionViewCell.self)")
    
    collectionView
      .rx
      .modelSelected(CategoryViewModel.self)
      .subscribe(onNext: {
        [unowned self] (model) in
        self.selectedCategory = model.displayCategoryName
        self.performSegue(withIdentifier: self.segueIdentifierEvent, sender: self)
      }).disposed(by: disposeBag)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
    
    collectionView.dataSource = nil
    
    viewModel.fetchCategoryViewModels()
      .observeOn(MainScheduler.instance)
      .bind(to: collectionView
        .rx
        .items(cellIdentifier: "\(SectionCollectionViewCell.self)",
               cellType: SectionCollectionViewCell.self)) {
                 [unowned self] index, viewModel, cell in
                 // size cell
                 let frameCV = self.collectionView.frame
                 let spacing = CGFloat(CGFloat((self.countCells + 1)) * self.offset) / CGFloat(self.countCells)
                 let widthCell = frameCV.width / CGFloat(self.countCells)
                 let heightCell = widthCell - 10
                 cell.bounds.size.width = widthCell - spacing
                 cell.bounds.size.height = heightCell - (self.offset * 2)
            
                 cell.configure(viewModel: viewModel)
      }
      .disposed(by: disposeBag)
  }
        
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard segue.identifier == segueIdentifierEvent else { return }
    guard let destination = segue.destination as? EventViewController else { return }
    destination.selectedCategory = self.selectedCategory
  }
  
}

