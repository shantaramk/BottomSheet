//
//  BottomSheetEventHandler.swift
//  CardView
//
//  Created by Shantaram K on 22/08/20.
//  Copyright © 2020 Shantaram Kokate. All rights reserved.
//

import Foundation
import UIKit

extension BottomSheetAdaptor {

    func configureGuesture() {
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(CardViewController.draggedView(_:)))
        child!.view.isUserInteractionEnabled = true
        child!.view.addGestureRecognizer(panGesture)
    }
}

extension BottomSheetAdaptor {

    @objc func draggedView(_ sender: UIPanGestureRecognizer){

        let velocity = sender.velocity(in: child!.view)

        if velocity.x > 0 {
            // user dragged towards the right
            print("user dragged towards the right")
          //  child!.arrowButton.setImage(#imageLiteral(resourceName: "up-arrow"), for: .normal)

        } else {
            //
            print("user dragged towards the left")
           // child!.arrowButton.setImage(#imageLiteral(resourceName: "down-arrow"), for: .normal)

        }

        let translation = sender.translation(in: child!.view)
        let ycoordintae = (child!.view.frame.origin.y) + translation.y
        print(ycoordintae,  child!.view.superview!.frame.height - child!.view.frame.height)

        let superViewFrame = child!.view.superview!.frame
        if sender.state == .ended {

            if ycoordintae <= superViewFrame.height - 100 {
                UIView.animate(withDuration: 0.2) {
                    self.child!.view.frame.origin.y = (self.child!.view.superview!.frame.height) - self.child!.view.frame.height
                    sender.setTranslation(CGPoint.zero, in: self.child!.view)
                }
            }
        } else {
            child!.view.bringSubview(toFront: child!.view)
            if ycoordintae <= self.child!.view.superview!.frame.height - child!.view.frame.height {
                return
            }
            self.child!.view.frame.origin.y = self.child!.view.frame.origin.y + translation.y
            sender.setTranslation(CGPoint.zero, in: child!.view)
        }

    }

}
