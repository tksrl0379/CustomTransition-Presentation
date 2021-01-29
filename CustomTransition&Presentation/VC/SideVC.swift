//
//  SecondVC.swift
//  CustomTransition&Presentation
//
//  Created by USER on 2021/01/28.
//

import UIKit

class SideVC: UIViewController {

    var swipeInteractionController: SwipeInteractionController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .lightGray
        
        swipeInteractionController = SwipeInteractionController(viewController: self)
    }
}
