//
//  CustomAnimator.swift
//  CustomTransition&Presentation
//
//  Created by USER on 2021/01/28.
//

import UIKit

class CustomAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    private let isPresenting: Bool
    private let duration: TimeInterval = 0.3
    
    init(isPresenting: Bool) {
        self.isPresenting = isPresenting
        
        super.init()
    }
    
    // 4
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        duration
    }
    
    // 5
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView
        
        let firstKey: UITransitionContextViewControllerKey = isPresenting ? .from : .to
        let secondKey: UITransitionContextViewControllerKey = isPresenting ? .to : .from
        
        let mainVC = transitionContext.viewController(forKey: firstKey)!
        let sideVC = transitionContext.viewController(forKey: secondKey)!
        
        if isPresenting {
            containerView.addSubview(sideVC.view)
        }
        
        let endFrame = transitionContext.finalFrame(for: sideVC)
        var startFrame = endFrame
        startFrame.origin.x -= startFrame.width

        let initialFrame = isPresenting ? startFrame : endFrame
        let finalFrame = isPresenting ? endFrame : startFrame
        
        sideVC.view.frame = initialFrame
        
        // 6
        UIView.animate(withDuration: duration) {
            sideVC.view.frame = finalFrame
            mainVC.view.frame.origin.x += (self.isPresenting ? finalFrame.width : -finalFrame.width)
        } completion: { _ in
            transitionContext.completeTransition(true)
        }
    }
}
