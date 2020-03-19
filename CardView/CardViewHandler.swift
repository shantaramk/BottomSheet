//
//  CardViewHandler.swift
//  CardView
//
//  Created by Shantaram Kokate on 1/23/19.
//  Copyright © 2019 Shantaram Kokate. All rights reserved.
//

import UIKit
import Foundation

class CardViewHandler: UIView {

    //MARK: - Internal Properties
    
    var childView: UIViewController? = nil
    var parentView: UIViewController? = nil

    //MARK: - init
    
    convenience init(childViewController: UIViewController, parentViewController: UIViewController) {
        self.init()
        self.childView = childViewController
        self.parentView = parentViewController
    }
}

// MARK: - Private methods

private extension CardViewHandler {
    
   func updateViewAppearance(_ yPoint: Int) {
        print(yPoint)
    }
}

// MARK: - UITouch Delegate

extension CardViewHandler {
    
   
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let currentPoint = touch.location(in: self.parentView?.view)
            updateViewAppearance(Int(currentPoint.y))
        }
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let currentPoint = touch.location(in: self.parentView?.view)
            updateViewAppearance(Int(currentPoint.y))
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let currentPoint = touch.location(in: self.parentView?.view)
            updateViewAppearance(Int(currentPoint.y))
        }
    }
}
