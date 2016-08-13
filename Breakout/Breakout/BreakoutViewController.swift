//
//  BreakoutVC.swift
//  Breakout
//
//  Created by Carl McCann on 14/04/2016.
//  Copyright © 2016 UCD CS. All rights reserved.
//

import UIKit

class BreakoutViewController: UIViewController,UIDynamicAnimatorDelegate, UICollisionBehaviorDelegate, GameOver{
    
    @IBOutlet weak var breakoutView: BreakoutView!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    var breakoutBehaviour = BreakoutBehaviour()
    
    private lazy var animator: UIDynamicAnimator = {
        let animator = UIDynamicAnimator(referenceView: self.breakoutView)
        animator.addBehavior(self.breakoutBehaviour)
        return animator
        }()
    // Do any additional setup after loading the view, typically from a nib.
    
    @IBAction func tapForGameStart(sender: UITapGestureRecognizer) {
        
        print("Tap")
        
        breakoutBehaviour.moveBalls()
        
    }
    @IBAction func paddlePanGesture(sender: UIPanGestureRecognizer) {
        print("panning:\t \(sender.translationInView(breakoutView).x)")
        
        print(sender.locationInView(breakoutView).x)
        
        // zooms to where finger currently is,
        let paddleWidth = NSUserDefaults.standardUserDefaults().floatForKey("paddle_width")
        breakoutView.paddle.frame.origin.x = sender.locationInView(breakoutView).x - CGFloat(paddleWidth / 2)
        
        breakoutBehaviour.removeBoundary("paddle")
        breakoutBehaviour.addBoundary(UIBezierPath(rect: breakoutView.paddle.frame), id: "paddle")        
        
        // to move relative to finger (not finished):
//        breakoutView.paddle.frame.origin.x = sender.velocityInView(breakoutView).x
        
//        breakoutView.paddle.frame.origin.y = sender.translationInView(breakoutView).y
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        NSUserDefaults.standardUserDefaults().setInteger(1, forKey: "balls")//default amount of balls
        NSUserDefaults.standardUserDefaults().setFloat(10.0, forKey: "ball_radius")  // default ball radius
        NSUserDefaults.standardUserDefaults().setFloat(60.0, forKey: "paddle_width") // default paddle size
        NSUserDefaults.standardUserDefaults().setInteger(20, forKey: "bricks")       // default amount of bricks
        animator.addBehavior(breakoutBehaviour)
        breakoutBehaviour.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
        
        breakoutView.autoresizesSubviews = true
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        print("view will appear")
        resetGame()
    }
    
    func sendAlert(msg : String) {
        let alertController = UIAlertController(title: "Breakout", message:
            msg, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: { Void in
            self.resetGame()
        }))
        
        self.presentViewController(alertController, animated: true, completion: nil)

    }
    
    func resetGame(){
        
        NSUserDefaults.standardUserDefaults().setInteger(0, forKey: "score")   // default score
        scoreLabel.text = String(NSUserDefaults.standardUserDefaults().integerForKey("score"))
        
        breakoutBehaviour.removeAllBoundaries()
        breakoutBehaviour.removeAllBalls()
        
        //        breakoutView.paddle.removeFromSuperview()
        for brick in breakoutView.bricks{
            brick.removeFromSuperview()
        }
        for ball in breakoutView.balls{
            ball.removeFromSuperview()
        }
        breakoutView.paddle.removeFromSuperview()
        
        
        breakoutView.addBricks(NSUserDefaults.standardUserDefaults().integerForKey("bricks"))
        breakoutView.addBalls(CGFloat(NSUserDefaults.standardUserDefaults().floatForKey("ball_radius")), noOfBalls: NSUserDefaults.standardUserDefaults().integerForKey("balls"))
        breakoutView.addPaddle(CGFloat(NSUserDefaults.standardUserDefaults().floatForKey("paddle_width")))
        
        breakoutBehaviour.addBalls(breakoutView.balls)
    
        var i = 0
        for brick in breakoutView.bricks{
            breakoutBehaviour.addBoundary(UIBezierPath(rect: brick.frame), id: "brick" + String(i))
            i += 1
        }
        breakoutBehaviour.addBoundary(UIBezierPath(rect: breakoutView.paddle.frame), id: "paddle")
        
        let from = CGPoint(x: breakoutView.frame.minX, y: breakoutView.frame.maxY)
        let to = CGPoint(x: breakoutView.frame.maxX, y: breakoutView.frame.maxY)
        breakoutBehaviour.addBoundary(from, to: to, id: "ball_gone")
        
        breakoutBehaviour.getBricksBallsAndScore(breakoutView.bricks, noOfBalls: breakoutView.balls.count, score: scoreLabel)
        
    }
}
