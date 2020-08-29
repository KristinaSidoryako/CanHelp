//
//  UIImageView.swift
//  MyApp
//
//  Created by Кристина Сидоряко on 23.08.2020.
//  Copyright © 2020 Кристина Сидоряко. All rights reserved.
//

import UIKit

extension UIImageView {
  
  func applyCutMask(image: UIImage, cutMask: UIImage) {
    let size = self.frame.size
    let rect =  CGRect(origin: CGPoint(x: 0, y: 0), size: size)
    
    UIGraphicsBeginImageContext(size)
    image.draw(in: rect)
    cutMask.draw(in: rect, blendMode: .destinationOut, alpha: 1.0)
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    self.image = newImage
  }
  
}
