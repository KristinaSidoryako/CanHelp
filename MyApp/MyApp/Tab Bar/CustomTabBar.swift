//
//  CustomTabBar.swift
//  MyApp
//
//  Created by Кристина Сидоряко on 13.07.2020.
//  Copyright © 2020 Кристина Сидоряко. All rights reserved.
//

import UIKit

@IBDesignable
class CustomTabBar: UITabBar {
   
  // MARK: Private Properties
  
  private var shapeLayer: CALayer?
  
  // MARK: Life Cycle
  
  override func draw(_ rect: CGRect) {
    self.addShape()
  }
  
  // MARK: Private Methods
  
  private func addShape() {
    let shapeLayer = CAShapeLayer()
    shapeLayer.path = createPath()
    shapeLayer.strokeColor = UIColor.lightGray.cgColor
    shapeLayer.fillColor = UIColor.white.cgColor
    shapeLayer.lineWidth = 0.3
    
    if let oldShapeLayer = self.shapeLayer {
      self.layer.replaceSublayer(oldShapeLayer, with: shapeLayer)
    } else {
      self.layer.insertSublayer(shapeLayer, at: 0)
    }
    
    self.shapeLayer = shapeLayer
  }
  
  private func createPath() -> CGPath {
    let height: CGFloat = 37.0
    let radius: CGFloat = 37.0
    let path = UIBezierPath()
    let centerWidth = self.frame.width / 2
    
    path.move(to: CGPoint(x: 0, y: 0))
    path.addLine(to: CGPoint(x: (centerWidth - height), y: 0))
    
    path.addArc(withCenter: CGPoint(x: centerWidth, y: 0), radius: radius, startAngle: .pi, endAngle: 0, clockwise: true)
    
    path.addLine(to: CGPoint(x: self.frame.width, y: 0))
    path.addLine(to: CGPoint(x: self.frame.width, y: self.frame.height))
    path.addLine(to: CGPoint(x: 0, y: self.frame.height))
    path.close()
    
    return path.cgPath
  }

}
