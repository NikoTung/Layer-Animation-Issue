//
//  ViewController.swift
//  HitTest
//
//  Created by NikoTung on 8/4/15.
//  Copyright © 2015 niko.com. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var movingLayer : CALayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layer = CALayer()
        layer.bounds = CGRectMake(0, 0, 100, 100)
        layer.backgroundColor = UIColor.orangeColor().CGColor
        layer.position = CGPointMake(100, 100)
        self.view.layer.addSublayer(layer)
        self.movingLayer = layer
        
        let moveLayerAnimation = CAKeyframeAnimation(keyPath: "position")
        let p = NSValue(CGPoint: CGPointMake(100, 150))
        let p2 = NSValue(CGPoint: CGPointMake(200, 250))
        let p3 = NSValue(CGPoint: CGPointMake(300, 400))
        let p4 = NSValue(CGPoint: CGPointMake(200, 550))
        
        moveLayerAnimation.values = [p , p2, p3, p4]
        moveLayerAnimation.fillMode = kCAFillModeForwards
        moveLayerAnimation.removedOnCompletion = false
        moveLayerAnimation.duration = 0.8
        moveLayerAnimation.repeatDuration = 4.0
        moveLayerAnimation.calculationMode = kCAAnimationCubic

        moveLayerAnimation.repeatCount = HUGE
        moveLayerAnimation.timingFunction  = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        self.movingLayer?.addAnimation(moveLayerAnimation, forKey: "move")
//        self.movingLayer!.position = CGPointMake(200, 350)
        
        let gesture = UITapGestureRecognizer(target: self, action: Selector("pressedLayer:"))
        self.view.addGestureRecognizer(gesture)
    }
    
    @IBAction func pressedLayer(gestureRecognizer : UIGestureRecognizer){
       let point = gestureRecognizer.locationInView(self.view)

        if let _ = self.movingLayer?.presentationLayer()?.hitTest(point) {
            self.blinkLayerWithColor(UIColor.yellowColor())
        } else if let _ = self.movingLayer?.hitTest(point) {
            self.blinkLayerWithColor(UIColor.redColor())
        }
    }
    
    func blinkLayerWithColor(color : UIColor) {
        let blinkAnimation = CABasicAnimation(keyPath: "backgroundColor")
        blinkAnimation.duration = 0.1
        blinkAnimation.autoreverses = true
        blinkAnimation.fromValue = self.movingLayer!.backgroundColor
        blinkAnimation.toValue = color.CGColor
        self.movingLayer?.addAnimation(blinkAnimation, forKey: "blink")
//
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

