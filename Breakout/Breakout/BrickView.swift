//
//  BrickView.swift
//  Breakout
//
//  Created by Carl McCann on 15/04/2016.
//  Copyright © 2016 UCD CS. All rights reserved.
//

import UIKit

class BrickView: UIView {
    override init(frame: CGRect){
        super.init(frame: frame)
        self.backgroundColor = UIColor.blueColor()
        self.layer.cornerRadius = self.frame.width / 8
    }
    required init?(coder aDecoder: NSCoder){
        fatalError("No NSCoding")
    }

}
