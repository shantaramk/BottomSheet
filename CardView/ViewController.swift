//
//  ViewController.swift
//  CardView
//
//  Created by Shantaram Kokate on 1/18/19.
//  Copyright © 2019 Shantaram Kokate. All rights reserved.
//

import UIKit

let ANIMATION_DURATION = 0.5
let CARDVIEW_HEIGHT: CGFloat = 410.0
let CARD_VISIBLE_VIEW_HEIGHT: CGFloat = 55.0

class ViewController: UIViewController {
    
    //MARK: Internal Properties
    
    var chaildView: CardViewController?
    var blurEffectView = UIVisualEffectView()
    
    var blurViewAlpha: CGFloat = 0.0 {
        didSet {
            blurEffectView.alpha = blurViewAlpha
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       // prepareForBlurView()
        prepareForCardView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func prepareForCardView() {
        let parent = self
        
        let child = CardViewController(cardName: "Steve Jobs", subTitle: "Apple Co-Founder")
        
        child.view.frame = CGRect(x: 0, y: self.view.frame.size.height - CARD_VISIBLE_VIEW_HEIGHT, width: self.view.frame.size.width, height: CARDVIEW_HEIGHT)
        
        // First, add the view of the child to the view of the parent
        parent.view.addSubview(child.view)
        
        // Then, add the child to the parent
        parent.addChildViewController(child)
        
        // Finally, notify the child that it was moved to a parent
        child.didMove(toParentViewController: parent)
        
        child.delegate = self
        chaildView = child
        //
        _ = CardViewHandler(childViewController: child, parentViewController: parent)
    }
    
    func prepareForBlurView() {
        let blurEffect = UIBlurEffect(style: .regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.alpha = 0
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        self.blurEffectView = blurEffectView
    }
    
}

//MARK: Private methods

extension ViewController {
    func updateViewAppearance(_ yPoint: CGFloat, completion: @escaping (Bool) -> Void) {
        
        UIView.animate(withDuration: ANIMATION_DURATION, animations: {
            self.chaildView?.view.frame = CGRect(x: 0, y: yPoint, width: (self.chaildView?.view.frame.size.width)!, height: CARDVIEW_HEIGHT)
        }) { (done) in
            _ = completion(done)
        }
    }
    
    func updateBlurViewAlpha(alpha: CGFloat) {
        if alpha == 0.0 {
            self.view.transform = .identity
        } else {
            self.view.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }
        //self.blurEffectView.alpha = alpha
    }
}

//MARK: EventHandler Delegate

extension ViewController: EventHandler {
    
    func didChange(to status: Bool) {
        if status {
            updateViewAppearance(self.view.frame.size.height - CARDVIEW_HEIGHT) { (completed) in
                self.updateBlurViewAlpha(alpha: 1.0)
            }
            
        } else {
            updateViewAppearance(self.view.frame.size.height - CARD_VISIBLE_VIEW_HEIGHT) { (completed) in
                self.updateBlurViewAlpha(alpha: 0.0)
            }
        }
    }
}
