//
//  SettingsTVC.swift
//  Breakout
//
//  Created by Carl McCann on 14/04/2016.
//  Copyright © 2016 UCD CS. All rights reserved.
//

import UIKit

class SettingsTVC: UITableViewController {
    
    @IBOutlet weak var noOfBalls: UISegmentedControl!
//    made momentary in attributes
    @IBOutlet weak var bricksIncDec: UISegmentedControl!
    @IBOutlet weak var brickCount: UILabel!
    @IBOutlet weak var paddleWidthSlider: UISlider!
    
    @IBAction func noOfBallsChanged(sender: UISegmentedControl) {
        let x = noOfBalls.selectedSegmentIndex + 1
        NSUserDefaults.standardUserDefaults().setInteger(x, forKey: "balls")
        print("Balls: \(NSUserDefaults.standardUserDefaults().integerForKey("balls"))")
    }

    @IBAction func noOfBricksChanged(sender: UISegmentedControl) {
        var x = 0;
        
        switch bricksIncDec.selectedSegmentIndex{
        case 0:
            if Int(brickCount.text!) > 5{
                x = -1
            }
        case 1:
            if Int(brickCount.text!) < 40{
                x = 1
            }
        default: print("Do Nothing, bricks change")
        }
        brickCount.text = String(Int(brickCount.text!)! + x)
        NSUserDefaults.standardUserDefaults().setInteger(Int(brickCount.text!)!, forKey: "bricks")
        print("Bricks: \(NSUserDefaults.standardUserDefaults().integerForKey("bricks"))")
    }
   
    @IBAction func paddleWidthChanged(sender: AnyObject) {
        
        NSUserDefaults.standardUserDefaults().setFloat(paddleWidthSlider.value, forKey: "bounciness")
        print("Paddle Width: \(NSUserDefaults.standardUserDefaults().floatForKey("bounciness"))")
        
        let paddleWidth = 180 * paddleWidthSlider.value
        NSUserDefaults.standardUserDefaults().setFloat(paddleWidth, forKey: "paddle_width")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
