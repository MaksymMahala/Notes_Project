//
//  RectangleView.swift
//  Notes
//
//  Created by Maksym on 27.11.2023.
//

import Foundation
import UIKit
import CoreGraphics


class RectangleView: UIView{
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder: ) has not been implemented")
    }
    
    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        let pathRect = CGRect(x: 0, y: 0, width: 380, height: 400)
        context.setFillColor(UIColor.systemTeal.cgColor)
        context.addRect(pathRect)
        context.fill(pathRect)
    }
}
