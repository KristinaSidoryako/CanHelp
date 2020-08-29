//
//  SectionCollectionViewCell.swift
//  MyApp
//
//  Created by Кристина Сидоряко on 13.07.2020.
//  Copyright © 2020 Кристина Сидоряко. All rights reserved.
//

import UIKit

class SectionCollectionViewCell: UICollectionViewCell {
  
  // MARK: IBOutlets

  @IBOutlet weak var iconImageView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  
  // MARK: Life Cycle
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  // MARK: Public Methods
  
  func configure(viewModel: CategoryViewModel) {
    DispatchQueue.global(qos: .utility).async {
      if let data = try? Data(contentsOf: viewModel.displayImage) {
        DispatchQueue.main.async {
          self.iconImageView.image = UIImage(data: data)
        }
      }
    }
    
    titleLabel.text = viewModel.displayCategoryName.capitalized
  }

}
