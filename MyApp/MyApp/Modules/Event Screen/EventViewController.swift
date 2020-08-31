//
//  EventViewController.swift
//  MyApp
//
//  Created by Кристина Сидоряко on 20.07.2020.
//  Copyright © 2020 Кристина Сидоряко. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol ButtonDelegate: class {
  func clickEventButton(currentEvent: String, currentId: Int, currentTitle: String)
}

class EventViewController: UIViewController {
  
  // MARK: IBOutlets
  
  @IBOutlet weak var viewSegmentedControl: UIView!
  @IBOutlet weak var eventsTableView: UITableView!
  
  // MARK: Public Properties
  
  let disposeBag = DisposeBag()
  var selectedCategory: String?
  var currentIdEvent: Int?
  var currentTitleEvent: String?
  
  // MARK: Private Properties
  
  private var viewModel: EventListViewModel!
  
  private let currentButton = UIButton(type: .custom)
  private let finishedButton = UIButton(type: .custom)
  
  private let segueIdentifierDescription = "segueScreenDescription"
  
  // MARK: Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    viewModel = EventListViewModel()
    
    navigationItem.title = selectedCategory?.capitalized
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(true)
    
    addSegmentedControl()
    
    eventsTableView.dataSource = nil
    
    viewModel.fetchEventViewModels(selectCategory: selectedCategory!)
      .observeOn(MainScheduler.instance)
      .bind(to: eventsTableView
        .rx
        .items(cellIdentifier: "\(EventTableViewCell.self)",
               cellType: EventTableViewCell.self)) {
                 [unowned self] index, viewModel, cell in
                 cell.configure(viewModel: viewModel, delegate: self)
      }
      .disposed(by: disposeBag)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard segue.identifier == segueIdentifierDescription else { return }
    guard let destination = segue.destination as? DescriptionNavigationController else { return }
    destination.currentCategory = self.selectedCategory
    destination.currentId = self.currentIdEvent
    destination.titleBar = self.currentTitleEvent
  }
  
  // MARK: Private Methods
  
  @objc private func selectedCurrentButton() {
    currentButton.isSelected = true
    finishedButton.isSelected = false
    currentButton.backgroundColor = .leafColor
    finishedButton.backgroundColor = .white
  }
   
  @objc private func selectedFinishedButton() {
    finishedButton.isSelected = true
    currentButton.isSelected = false
    finishedButton.backgroundColor = .leafColor
    currentButton.backgroundColor = .white
  }
  
  private func addSegmentedControl() {
    // add buttons
    let widthView = viewSegmentedControl.bounds.size.width
    let heightView = viewSegmentedControl.bounds.size.height
    let width = Double(widthView / 2.0 - 16.0)
    let height = 24.0
      
    currentButton.frame = CGRect(x: 0.0, y: 0.0, width: width, height: height)
    currentButton.backgroundColor = .leafColor
    var centerCurrentButton: CGPoint = viewSegmentedControl.center
    centerCurrentButton.x = widthView / 4 + 16
    centerCurrentButton.y = heightView / 2
    currentButton.center = centerCurrentButton
    viewSegmentedControl.addSubview(currentButton)
    
    finishedButton.frame = CGRect(x: 0.0, y: 0.0, width: width, height: height)
    finishedButton.backgroundColor = .white
    var centerFinishedButton: CGPoint = viewSegmentedControl.center
    centerFinishedButton.x += widthView / 4 - 16
    centerFinishedButton.y = heightView / 2
    finishedButton.center = centerFinishedButton
    viewSegmentedControl.addSubview(finishedButton)
      
    // setup buttons
    currentButton.isSelected = true
    currentButton.layer.cornerRadius = 4
    currentButton.layer.borderWidth = 1.0
    let borderColor = UIColor.leafColor
    currentButton.layer.borderColor = borderColor.cgColor
    currentButton.clipsToBounds = true
    currentButton.setTitle("Текущие", for: .normal)
    currentButton.setTitleColor(.white, for: .selected)
    currentButton.setTitleColor(.leafColor, for: .normal)
    if let fontTitle_1 = UIFont(name: "SFUIText-Regular", size: 13) {
      currentButton.titleLabel?.font = fontTitle_1
      finishedButton.titleLabel?.font = fontTitle_1
    } else {
      print("not exist needed font")
    }
      
    finishedButton.layer.cornerRadius = 4
    finishedButton.layer.borderWidth = 1.0
    finishedButton.layer.borderColor = borderColor.cgColor
    finishedButton.clipsToBounds = true
    finishedButton.setTitle("Завершенные", for: .normal)
    finishedButton.setTitleColor(.white, for: .selected)
    finishedButton.setTitleColor(.leafColor, for: .normal)
    
    currentButton.addTarget(self, action: #selector(selectedCurrentButton), for: .touchUpInside)
    finishedButton.addTarget(self, action: #selector(selectedFinishedButton), for: .touchUpInside)
  }

}

// MARK: ButtonDelegate

extension EventViewController: ButtonDelegate {
  
  func clickEventButton(currentEvent: String, currentId: Int, currentTitle: String) {
    selectedCategory = currentEvent
    currentIdEvent = currentId
    currentTitleEvent = currentTitle
    
    performSegue(withIdentifier: segueIdentifierDescription, sender: self)
  }

}

