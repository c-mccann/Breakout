//
//  BreakoutView.swift
//  Breakout
//
//  Created by Carl McCann on 14/04/2016.
//  Copyright © 2016 UCD CS. All rights reserved.
//

import UIKit

class BreakoutView: UIView, UIDynamicAnimatorDelegate {
    
    var paddle = PaddleView()
    var ball = BallView()
    var balls = [BallView]()
    var bricks = [BrickView]()
    
    
    func addPaddle(paddleWidth: CGFloat){
        paddle = PaddleView()
        paddle = PaddleView(frame: CGRect(origin: CGPoint(x: ((self.bounds.width / 2) - (paddleWidth / 2)), y: (self.bounds.size.height - 100)), size: CGSize(width: paddleWidth, height: CGFloat(5))))
        self.addSubview(paddle)
        
    }
    
    func addBalls(ballRadius: CGFloat, noOfBalls: Int){
        balls.removeAll()
        for i in 0...(noOfBalls - 1) {
            ball = BallView(frame: CGRect(origin: CGPoint(x: ((self.bounds.width/2) - (ballRadius/2)), y: (self.bounds.height - CGFloat(120 + (CGFloat(i) * (ballRadius * 2))))), size: CGSize(width: ballRadius * 2, height: ballRadius*2)))
//            self.addSubview(ball)
            balls.append(ball)
            self.addSubview(ball)

        }
        
    }
    
    func addBricks(noOfBricks: Int){
        bricks.removeAll()
        
        for object in self.subviews{
            if object.superclass == BrickView.superclass(){
                self.willRemoveSubview(object)
            }
        }
        bricks = [BrickView]()
        var row = 0
    
        for count in 0...(noOfBricks - 1){
            if count > 0{
                if count % 5 == 0{
                    row += 1
                }
            }
        
            let currentBrick = BrickView(frame: CGRect(origin: CGPoint(x: ((self.bounds.width/5) * CGFloat(count % 5)), y: CGFloat(40 + (row * 20))), size: CGSize(width: self.bounds.width / 5, height: CGFloat(15))))
            bricks.append(currentBrick)
        }
        
        for brick in bricks as [BrickView]{
            self.addSubview(brick)
        }
    }
}
