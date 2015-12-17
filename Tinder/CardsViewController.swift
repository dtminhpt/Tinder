//
//  CardsViewController.swift
//  Tinder
//
//  Created by Dinh Thi Minh on 12/16/15.
//  Copyright © 2015 Dinh Thi Minh. All rights reserved.
//

import UIKit

class CardsViewController: UIViewController {
  var imageOriginalCenter: CGPoint!
  var direction: CGFloat = 1.0
  
  var isPresenting: Bool = true
  
  @IBOutlet weak var customProfileImageView: DraggableImageView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    customProfileImageView.image = UIImage(named: "ryan")
    
    imageOriginalCenter = customProfileImageView.center
  }
  
  @IBAction func onReset(sender: UIButton) {
    resetImage()
  }
  
  func resetImage() {
    customProfileImageView.center = imageOriginalCenter
    customProfileImageView.transform = CGAffineTransformMakeRotation(0)
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
    let destinationVC = segue.destinationViewController as UIViewController
    destinationVC.modalPresentationStyle = UIModalPresentationStyle.Custom
    destinationVC.transitioningDelegate = self
  }
  
  @IBAction func onPan(sender: UIPanGestureRecognizer) {
    let translation = sender.translationInView(view)
    let point = sender.locationInView(view)
    
    if sender.state == .Began {
      
      direction = point.y > 152 ? -0.2 : 0.2
      
    } else if sender.state == .Changed {
      
      customProfileImageView.center = CGPoint(x: imageOriginalCenter.x + translation.x, y: imageOriginalCenter.y)
      
      customProfileImageView.transform = CGAffineTransformMakeRotation((direction * translation.x * CGFloat(M_PI)) / 180.0)
    } else if sender.state == .Ended {
      if translation.x > 50 {
        UIView.animateWithDuration(1.0, animations: { () -> Void in
          self.customProfileImageView.center = CGPoint(x: 600, y: self.imageOriginalCenter.y)
        })
      } else if translation.x < -50 {
        UIView.animateWithDuration(1.0, animations: { () -> Void in
          self.customProfileImageView.center = CGPoint(x: -300, y: self.imageOriginalCenter.y)
        })
      } else {
        UIView.animateWithDuration(0.5, animations: { () -> Void in
          self.resetImage()
        })
      }
    }
  }
}

extension CardsViewController: UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {
  
  func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    isPresenting = true
    return self
  }
  
  func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    isPresenting = false
    return self
  }
  
  func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
    // The value here should be the duration of the animations scheduled in the animationTransition method
    return 0.4
  }
  
  func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
    // TODO: animate the transition in Step 3 below
    print("animating transition")
    let containerView = transitionContext.containerView()!
    let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
    let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
    
    if (isPresenting) {
      containerView.addSubview(toViewController.view)
      toViewController.view.alpha = 0
      UIView.animateWithDuration(0.4, animations: { () -> Void in
        toViewController.view.alpha = 1
        }) { (finished: Bool) -> Void in
          transitionContext.completeTransition(true)
      }
    } else {
      UIView.animateWithDuration(0.4, animations: { () -> Void in
        fromViewController.view.alpha = 0
        }) { (finished: Bool) -> Void in
          transitionContext.completeTransition(true)
          fromViewController.view.removeFromSuperview()
      }
    }
  }
}