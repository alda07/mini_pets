//
//  Extension.swift
//  Husky
//
//  Created by HanhVo on 6/8/16.
//  Copyright © 2016 HanhVo. All rights reserved.
//

import Foundation
import CoreGraphics
import UIKit

internal extension Float {
    
    var radians: Float {
        return self * (Float(180) / Float(M_PI))
    }
    
    var degrees: Float {
        return self  * Float(M_PI) / 180.0
    }
}

internal extension UIView {
    
    var angleZ: Float {
        let radians: Float = atan2(Float(self.transform.b), Float(self.transform.a))
        return radians.radians
    }
}


extension UIImage {
    
    func imageMaskedWithPolygon(slides: NSInteger) -> UIImage {
        
        UIGraphicsBeginImageContextWithOptions(self.size, true, self.scale);
        let context  = UIGraphicsGetCurrentContext();
        let path : UIBezierPath = Util.polygonPathWithRect(CGRectMake(0, 0, self.size.width, self.size.height), sides: slides)
        CGContextSaveGState(context)
        path.addClip()
        self.drawAtPoint(CGPointZero)
        CGContextRestoreGState(context);
        let resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext()
        return resultImage
    }
    
    func cropToBounds(size: CGSize) -> UIImage {
        
        let contextImage: UIImage = UIImage(CGImage: self.CGImage!)
        
        let contextSize: CGSize = contextImage.size
        
        var posX: CGFloat = 0.0
        var posY: CGFloat = 0.0
        var cgwidth: CGFloat = CGFloat(size.width)
        var cgheight: CGFloat = CGFloat(size.height)
        
        // See what size is longer and create the center off of that
        if contextSize.width > contextSize.height {
            posX = ((contextSize.width - contextSize.height) / 2)
            posY = 0
            cgwidth = contextSize.height
            cgheight = contextSize.height
        } else {
            posX = 0
            posY = ((contextSize.height - contextSize.width) / 2)
            cgwidth = contextSize.width
            cgheight = contextSize.width
        }
        
        let rect: CGRect = CGRectMake(posX, posY, cgwidth, cgheight)
        
        // Create bitmap image from context using the rect
        let imageRef: CGImageRef = CGImageCreateWithImageInRect(contextImage.CGImage, rect)!
        
        // Create a new image based on the imageRef and rotate back to the original orientation
        let image: UIImage = UIImage(CGImage: imageRef, scale: self.scale, orientation: self.imageOrientation)
        
        return image
    }
    
}


