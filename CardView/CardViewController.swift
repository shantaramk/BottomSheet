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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        prepareCardView()
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
