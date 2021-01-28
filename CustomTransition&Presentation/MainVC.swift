//
//  ViewController.swift
//  CustomTransition&Presentation
//
//  Created by USER on 2021/01/28.
//

import UIKit

class MainVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rect = UIView()
        rect.frame = CGRect(x: 30, y: self.view.frame.height/2, width: 50, height: 50)
        rect.backgroundColor = .red
        self.view.addSubview(rect)
        
        UIView.animate(withDuration: 3.0, delay: 0, options: [.repeat, .curveLinear]) {
            rect.transform = CGAffineTransform(rotationAngle: .pi)
        }
    }


    @IBAction func menuButtonTapped(_ sender: Any) {
        let secondVC = storyboard!.instantiateViewController(identifier: "SideVC")
        
        // 0
        secondVC.modalPresentationStyle = .custom
        secondVC.transitioningDelegate = self
        
        present(secondVC, animated: true)
    }
}


extension MainVC: UIViewControllerTransitioningDelegate {
    
    // 1
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        CustomPresentationController(presentedViewController: presented, presenting: presenting)
    }
    
    // 2
//    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        return CustomAnimator(isPresenting: true)
//    }
//
//    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        return CustomAnimator(isPresenting: false)
//    }
}
