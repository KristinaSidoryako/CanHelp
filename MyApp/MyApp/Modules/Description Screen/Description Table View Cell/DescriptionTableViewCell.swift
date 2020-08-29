//
//  DescriptionTableViewCell.swift
//  MyApp
//
//  Created by Кристина Сидоряко on 22.07.2020.
//  Copyright © 2020 Кристина Сидоряко. All rights reserved.
//

import UIKit

class DescriptionTableViewCell: UITableViewCell {
  
  // MARK: IBOutlets
  
  @IBOutlet weak var title: UILabel!
  @IBOutlet weak var date: UILabel!
  @IBOutlet weak var fond: UILabel!
  @IBOutlet weak var adress: UILabel!
  @IBOutlet weak var phone: UILabel!
  @IBOutlet weak var imageFirst: UIImageView!
  @IBOutlet weak var imageSecond: UIImageView!
  @IBOutlet weak var imageThird: UIImageView!
  @IBOutlet weak var descriptionFirst: UILabel!
  @IBOutlet weak var descriptionSecond: UILabel!
  @IBOutlet weak var underlineFirst: UILabel!
  @IBOutlet weak var underlineSecond: UILabel!
  
  // MARK: Life Cycle
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
  // MARK: Public Methods
  
  func configure(viewModel: EventViewModel) {
    title.text = viewModel.displayMainTitle
    date.text = viewModel.displayDateText
    fond.text = "Благотворительный фонд \"\(viewModel.displayFond)\""
    adress.text = viewModel.displayAdress
    for elem in viewModel.displayPhone {
      phone.text! += "\(elem)\n"
    }
    
    DispatchQueue.global(qos: .utility).async {
      if let data = try? Data(contentsOf: viewModel.displayIconImage) {
        DispatchQueue.main.async {
          self.imageFirst.image = UIImage(data: data)
        }
      }
    }
  
    imageSecond.image = UIImage(named: viewModel.displayIcons[0])
    imageThird.image = UIImage(named: viewModel.displayIcons[1])
    descriptionFirst.text = viewModel.displayDescription[0]
    descriptionSecond.text = viewModel.displayDescription[1]

    underlineFirst.attributedText = NSAttributedString(string: "Напишите нам", attributes:
      [.underlineStyle: NSUnderlineStyle.single.rawValue])
    underlineSecond.attributedText = NSAttributedString(string: "Перейти на сайт организации", attributes:
    [.underlineStyle: NSUnderlineStyle.single.rawValue])
  }

}
