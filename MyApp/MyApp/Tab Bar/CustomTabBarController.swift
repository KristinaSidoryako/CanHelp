//
//  CustomTabBarController.swift
//  MyApp
//
//  Created by Кристина Сидоряко on 13.07.2020.
//  Copyright © 2020 Кристина Сидоряко. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {
  
  // MARK: Private Properties
  
  private var centerButton: UIButton?
  private let indexCenterButton: Int = Int(floor(Double(5 / 2)))
   
  // MARK: Life Cycle 
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    selectedIndex = Int(indexCenterButton)
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(true)
    if let newButtonImage = UIImage(named: "heart") {
      addCenterButton(withImage: newButtonImage, highlightImage: newButtonImage)
    }
  }
  
  override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
    if item != tabBar.items![indexCenterButton] {
      centerButton?.backgroundColor = .melonColor
      centerButton?.isSelected = false
    } else {
      centerButton?.backgroundColor = .leafColor
      centerButton?.isSelected = true
    }
  }
  
  // MARK: Private Methods
   
  @objc private func handleTouchTabbarCenter(){
    selectedViewController = viewControllers?[indexCenterButton]

    centerButton?.backgroundColor = .leafColor
    centerButton?.isSelected = true
  }

  private func addCenterButton(withImage buttonImage : UIImage, highlightImage: UIImage) {
    centerButton = UIButton(type: .custom)
    centerButton?.autoresizingMask = [.flexibleRightMargin, .flexibleTopMargin, .flexibleLeftMargin, .flexibleBottomMargin]
    centerButton?.frame = CGRect(x: 0.0, y: 0.0, width: 50, height: 50)
    centerButton?.backgroundColor = .leafColor
    centerButton?.layer.cornerRadius = 0.5 * centerButton!.bounds.size.width
    centerButton?.clipsToBounds = true
         
    centerButton?.setImage(buttonImage, for: .normal)
    
    // compute center of button and call addCenterButton in viewDidAppear to get needed size
    var center: CGPoint =  tabBar.center
    center.y -= tabBar.bounds.size.height / 2
    centerButton?.center = center

    view.addSubview(centerButton!)
    tabBar.bringSubviewToFront(centerButton!)

    centerButton?.addTarget(self, action: #selector(handleTouchTabbarCenter), for: .touchUpInside)
  }

}
