//
//  Util.swift
//  Husky
//
//  Created by HanhVo on 6/8/16.
//  Copyright © 2016 HanhVo. All rights reserved.
//

import Foundation
import CoreGraphics
import UIKit

class Util{
    
    class func polygonPathWithRect(square: CGRect, sides:Int) -> UIBezierPath {
        
        let path = UIBezierPath()
        
        let a: CGFloat = 2.0
        let b: CGFloat = CGFloat(M_PI / Double(sides))
        let theta = a * b
        let c: CGFloat = CGFloat(cosf(Float(theta) / 2.0))
        let d: CGFloat = CGFloat(tanf(Float(theta) / 2.0))
        let squareWidth = min(square.size.width, square.size.height)
        
        var length = squareWidth
        
        if sides % 4 != 0 {
            
            length = length * c
        }
        
        let sideLength = length * d
        
        var point = CGPoint(x: squareWidth / 2.0 + sideLength / 2.0, y: squareWidth - (squareWidth - length) / 2.0)
        var angle = CGFloat(M_PI)
        path.moveToPoint(point)
        
        
        for (var side = 0; side < sides; side++) {
            let x: CGFloat = point.x + sideLength * CGFloat(cosf(Float(angle)))
            let y: CGFloat = point.y + sideLength * CGFloat(sinf(Float(angle)))
            point = CGPointMake(x, y)
            path.addLineToPoint(point)
            angle += theta
        }
        
        path.closePath()
        return path
    }

}