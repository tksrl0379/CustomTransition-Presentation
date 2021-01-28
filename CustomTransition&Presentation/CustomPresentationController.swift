//
//  CustomPresentationController.swift
//  CustomTransition&Presentation
//
//  Created by USER on 2021/01/28.
//

import UIKit

class CustomPresentationController: UIPresentationController {
    
    private var dimmingView: UIView
    
    override var frameOfPresentedViewInContainerView: CGRect {
        var presentedViewFrame: CGRect = .zero
        let containerBounds = containerView!.bounds
        
        presentedViewFrame.size = CGSize(width: containerBounds.width * 0.7,
                                         height: containerBounds.height)
        
        return presentedViewFrame
    }
    
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        dimmingView = UIView()
        
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        
        dimmingView.translatesAutoresizingMaskIntoConstraints = false
        dimmingView.backgroundColor = UIColor(white: 0, alpha: 0.1)
        dimmingView.alpha = 0
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(dimmingViewTapped))
        dimmingView.addGestureRecognizer(recognizer)
    }
    
    
    // MARK: Presentaiton
    
    // 3
    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        
        let containerViewBounds = containerView!.bounds
        
        dimmingView.frame = containerViewBounds
        dimmingView.alpha = 0
        
        containerView?.insertSubview(dimmingView, at: 0)
        
        guard let coordinator = presentedViewController.transitionCoordinator else {
            dimmingView.alpha = 1
//            presentingViewController.view.frame.origin.x += presentedView!.frame.width
            return
        }
        
        
        // animator 객체의 animateTransition 메서드 내의 UIView.animate 와 동시에 수행
        coordinator.animate { _ in
            // 6
            self.dimmingView.alpha = 1
//            self.presentingViewController.view.frame.origin.x += self.presentedView!.frame.width
        }
    }
    
    
    // MARK: Dismissal
    
    override func dismissalTransitionWillBegin() {
        guard let coordinator = presentedViewController.transitionCoordinator else {
            dimmingView.alpha = 0
//            presentingViewController.view.frame.origin.x -= presentedView!.frame.width
            return
        }
        
        
        coordinator.animate(alongsideTransition: { _ in
            self.dimmingView.alpha = 0
//            self.presentingViewController.view.frame.origin.x -= self.presentedView!.frame.width
        })
    }
}

extension CustomPresentationController {
    @objc
    func dimmingViewTapped() {
        presentingViewController.dismiss(animated: true)
    }
}
