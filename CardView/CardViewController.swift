//
//  CardViewController.swift
//  CardView
//
//  Created by Shantaram Kokate on 1/18/19.
//  Copyright © 2019 Shantaram Kokate. All rights reserved.
//

import UIKit

protocol EventHandler {
    func didChange(to status: Bool)
}

class CardViewController: UIViewController {

    @IBOutlet weak var arrowButton: UIButton!
    @IBOutlet weak var cardNameLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!

    var cardName: String?
    var subTitleName: String?
    
    var isShown = false {
        didSet {
            arrowButton.setImage((isShown == true) ? #imageLiteral(resourceName: "down-arrow") : #imageLiteral(resourceName: "up-arrow"), for: .normal)
        }
    }

    var delegate: EventHandler?
    var panGesture       = UIPanGestureRecognizer()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        prepareCardView()
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(CardViewController.draggedView(_:)))
        self.view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(panGesture)

    }

    @objc func draggedView(_ sender: UIPanGestureRecognizer){

        let velocity = sender.velocity(in: self.view)

        if velocity.x > 0 {
            // user dragged towards the right
            print("user dragged towards the right")
            arrowButton.setImage(#imageLiteral(resourceName: "up-arrow"), for: .normal)

        } else {
            //
            print("user dragged towards the left")
            arrowButton.setImage(#imageLiteral(resourceName: "down-arrow"), for: .normal)

        }

        let translation = sender.translation(in: self.view)
        let ycoordintae = self.view.frame.origin.y + translation.y
        print(ycoordintae,  self.view.superview!.frame.height - self.view.frame.height)

        let superViewFrame = self.view.superview!.frame
        if sender.state == .ended {

            if ycoordintae <= superViewFrame.height - 100 {
                UIView.animate(withDuration: 0.2) {
                    self.view.frame.origin.y = self.view.superview!.frame.height - self.view.frame.height
                    sender.setTranslation(CGPoint.zero, in: self.view)
                }
            } 
        } else {
            self.view.bringSubview(toFront: self.view)
            if ycoordintae <= self.view.superview!.frame.height - self.view.frame.height {
                return
            }
            self.view.frame.origin.y = self.view.frame.origin.y + translation.y
            sender.setTranslation(CGPoint.zero, in: self.view)
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    init(cardName:String, subTitle: String) {
        super.init(nibName: "CardViewController", bundle: nil)
        self.subTitleName = subTitle
        self.cardName = cardName
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func prepareCardView() {
        self.cardNameLabel.text = cardName
        self.subTitleLabel.text = subTitleName
    }
}

//MARK: Action Handler

extension CardViewController {
    
    @IBAction func toggleButtonClick(_ sender: Any) {
        if isShown {
            isShown = false
        } else {
            isShown = true
        }
        delegate?.didChange(to: isShown)
    }
}
