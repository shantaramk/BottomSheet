//
//  BottomSheetAdaptor.swift
//  CardView
//
//  Created by Shantaram K on 22/08/20.
//  Copyright © 2020 Shantaram Kokate. All rights reserved.
//

import Foundation
import UIKit

public protocol DragableSheet {

}

class BottomSheetAdaptor: DragableSheet {

    //Internal Properties

    private var delegate: DragableSheet?

    var parent: UIViewController?

    var child: UIViewController?

    var panGesture = UIPanGestureRecognizer()

    
    //init Method

    private init() {

    }

    convenience init(with parent: UIViewController, dragableSheet: DragableSheet? = nil) {

        self.init()

        self.delegate = dragableSheet

        self.parent = parent

    }

    func addSheet(_ view: UIViewController, to parent: UIViewController) {

        self.addChildViewController(view, to: parent)
    }

    private func addChildViewController(_ child: UIViewController, to parent: UIViewController) {

        self.child = child

        self.parent = parent

        let parent = parent

        self.configureGuesture()

        let child = child

        child.view.frame = CGRect(x: 0, y: parent.view.frame.size.height - CARD_VISIBLE_VIEW_HEIGHT, width: parent.view.frame.size.width, height: CARDVIEW_HEIGHT)

        // First, add the view of the child to the view of the parent
        parent.view.addSubview(child.view)

        // Then, add the child to the parent
        parent.addChildViewController(child)

        // Finally, notify the child that it was moved to a parent
        child.didMove(toParentViewController: parent)

     //   child.delegate = self
      //  chaildView = child
        //
       // _ = CardViewHandler(childViewController: child, parentViewController: parent)
    }

}
