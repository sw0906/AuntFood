//
//  FaceView.swift
//  AuntFood
//
//  Created by admin on 6/28/16.
//  Copyright © 2016 shou. All rights reserved.
//

import UIKit


@IBDesignable
class FaceView: UIView {
    @IBInspectable
    var scaleV: CGFloat = 0.7
    
    override func drawRect(rect: CGRect) {
        let skullRadius = min(bounds.size.width, bounds.size.height) / 2
        let skullCenter = CGPoint(x: bounds.midX, y: bounds.midY)
        
        let skull = UIBezierPath(arcCenter: skullCenter, radius: skullRadius, startAngle: 0.0, endAngle: CGFloat(2 * M_PI), clockwise: false)
        skull.lineWidth = 5.0
        skull.applyTransform(CGAffineTransformMakeScale(scaleV, scaleV))
        UIColor.blueColor().set()
        skull.stroke()
    }
    

}
