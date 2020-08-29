//
//  EventTableViewCell.swift
//  MyApp
//
//  Created by Кристина Сидоряко on 20.07.2020.
//  Copyright © 2020 Кристина Сидоряко. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {
  
  // MARK: IBOutlets

  @IBOutlet weak var mainTitleLabel: UILabel!
  @IBOutlet weak var mainEventButton: UIButton!
  @IBOutlet weak var iconImageView: UIImageView!
  @IBOutlet weak var smallImageView: UIImageView!
  @IBOutlet weak var bigLabel: UILabel!
  
  // MARK: Public Properties
  
  var currentId: Int?
  var currentEvent: String?
  var currentTitle: String?
  
  // MARK: Private Properties
   
  private weak var delegate:  ButtonDelegate?

  // MARK: Life Cycle
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }

  // MARK: Public Methods
  
  func configure(viewModel: EventViewModel, delegate: ButtonDelegate) {
    currentId = viewModel.displayId
    currentEvent = viewModel.displayCategoryEvent
    currentTitle = viewModel.displayMainTitle
    self.delegate = delegate
    
    DispatchQueue.global(qos: .utility).async {
      if let data = try? Data(contentsOf: viewModel.displayIconImage) {
        DispatchQueue.main.async {
          self.iconImageView.image = UIImage(data: data)
          // mask for iconImageView
          if let image = self.iconImageView.image, let cutMask = UIImage(named: "mask") {
            self.iconImageView.applyCutMask(image: image, cutMask: cutMask)
          } else {
            print("not exist needed images")
          }
        }
      }
    }
    
    mainTitleLabel.text = viewModel.displayMainTitle
    bigLabel.text = viewModel.displayMainText
    mainEventButton.setTitle(viewModel.displayDateText, for: .normal)
  }
  
  // MARK: IBActions
  
  @IBAction func openDescription(_ sender: UIButton) {
    delegate?.clickEventButton(currentEvent: currentEvent!, currentId: currentId!, currentTitle: currentTitle!)
  }
  
}


