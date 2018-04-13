//
//  AnimationDelegate.swift
//  Bookiie
//
//  Created by HanhVo on 5/13/16.
//  Copyright © 2016 HanhVo. All rights reserved.
//

import QuartzCore

class AnimationDelegate {
    
    private let completion: () -> Void
    
    init(completion: () -> Void) {
        
        self.completion = completion
    }
    
    dynamic func animationDidStop(_: CAAnimation, finished: Bool) {
        
        completion()
    }
}

