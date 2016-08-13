//
//  BreakoutBehaviour.swift
//  Breakout
//
//  Created by Carl McCann on 14/04/2016.
//  Copyright © 2016 UCD CS. All rights reserved.
//

import UIKit

protocol GameOver{
    func sendAlert(msg : String)
}

class BreakoutBehaviour: UIDynamicBehavior, UIDynamicAnimatorDelegate, UICollisionBehaviorDelegate {
    
    var bricks = [BrickView]()
    var brickCount = -1
    var ballCount = -1
    var scoreLabel = UILabel()
    var delegate = GameOver?()
    
    lazy var collider: UICollisionBehavior = {
        let collider = UICollisionBehavior()
        collider.translatesReferenceBoundsIntoBoundary = true
        collider.collisionDelegate = self
        return collider
    }()
    
    
    private lazy var ballBehaviour: UIDynamicItemBehavior = {
        let ballBehaviour = UIDynamicItemBehavior()
        ballBehaviour.allowsRotation = false
        ballBehaviour.elasticity = 1
        ballBehaviour.friction = 0
        ballBehaviour.resistance = 0
        return ballBehaviour
    }()
    
    func moveBalls(){
        for ball in ballBehaviour.items {
//            taking the second value away from the first allows for random movement left and right
            let x_val = CGFloat(arc4random_uniform(300)) - CGFloat(arc4random_uniform(300))
//            varies the speed
            let y_val = CGFloat(arc4random_uniform(300)) + 200
            ballBehaviour.addLinearVelocity(CGPoint(x: x_val,y: -y_val), forItem: ball)
          
        }
    }
    
    func addBalls(balls: [BallView]){
        print("Adding Balls")
        
        for ball in ballBehaviour.items{
            ballBehaviour.removeItem(ball)
        }
        for ball in balls{
            collider.addItem(ball)
            ballBehaviour.addItem(ball)
        }
    }
    
    func addBoundary(bezPath: UIBezierPath, id: String){
        collider.addBoundaryWithIdentifier(id, forPath: bezPath)
    }
    func addBoundary(from: CGPoint, to: CGPoint, id: String){
        collider.addBoundaryWithIdentifier(id, fromPoint: from, toPoint: to)        
    }
    
    func removeAllBoundaries(){
        collider.removeAllBoundaries()
    }
    func removeBoundary(id: String){
        collider.removeBoundaryWithIdentifier(id)
    }
    func removeAllBalls(){
        for item in collider.items{
            collider.removeItem(item)
        }
    }
    
    
    func collisionBehavior(behavior: UICollisionBehavior, beganContactForItem item: UIDynamicItem, withBoundaryIdentifier boundaryId: NSCopying?, atPoint p: CGPoint) {
        
        if boundaryId != nil{
            let boundary = String(boundaryId).substringWithRange(String(boundaryId).startIndex.advancedBy(9)..<String(boundaryId).endIndex.advancedBy(-1))
            
            let brickIndex = boundary.substringFromIndex(boundary.startIndex.advancedBy(5))
            let brickIndexAsInt = Int(brickIndex)
            
            if brickIndexAsInt != nil{
                scoreLabel.text = String(Int(scoreLabel.text!)! + 1)
                print(bricks.count)
                UIView.animateWithDuration(0.5, animations: {
                    self.bricks[brickIndexAsInt!].alpha = 0
                    }, completion: { (success) in
                        if success {
                            self.bricks[brickIndexAsInt!].removeFromSuperview()
                        }
                })

                removeBoundary(boundary)
//                also remove from view
                print(brickIndexAsInt)
                brickCount -= 1
                
                if brickCount == 0 {
                    delegate?.sendAlert("Congratulations!\n You Scored " + scoreLabel.text! + " points")
                }
                
            }
            if boundary == "ball_gone"{
                if let b = item as? BallView {
                    b.removeFromSuperview()
                    collider.removeItem(b)
                    ballCount -= 1
                    if ballCount == 0{
                        delegate?.sendAlert("Failure!\n You Scored " + scoreLabel.text! + " points")
                    }
                    
                }
            }
                
        }
    }
    func getBricksBallsAndScore(bricks: [BrickView], noOfBalls: Int, score: UILabel){
        self.bricks = bricks
        self.brickCount = bricks.count
        self.scoreLabel = score
        self.ballCount = noOfBalls
    }
    
    override init() {
        super.init()
        addChildBehavior(ballBehaviour)
        addChildBehavior(collider)
    }
}
