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
    
    @IBOutlet weak var customProfileImageView: DraggableImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        customProfileImageView.image = UIImage(named: "ryan")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func onPan(sender: UIPanGestureRecognizer) {
        let translation = sender.translationInView(view)
        let point = sender.locationInView(view)

        if sender.state == .Began {
            imageOriginalCenter = customProfileImageView.center
        
            if point.y  >= 157 {
                direction = -0.5
                print("bottom")
            } else {
                direction = 0.5
                print("top")
            }
        } else if sender.state == .Changed {
            
//            customProfileImageView.center = CGPoint(x: imageOriginalCenter.x + translation.x, y: imageOriginalCenter.y)
//    
            customProfileImageView.transform = CGAffineTransformMakeRotation((direction * translation.x * CGFloat(M_PI)) / 180.0)
        }
    }
}

