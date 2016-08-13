//
//  PaddleView.swift
//  Breakout
//
//  Created by Carl McCann on 15/04/2016.
//  Copyright © 2016 UCD CS. All rights reserved.
//

import UIKit

class PaddleView: UIView {
    override init(frame: CGRect){
        super.init(frame: frame)
        self.backgroundColor = UIColor.darkGrayColor()
        self.layer.cornerRadius = self.frame.width / 20
    }
    required init?(coder aDecoder: NSCoder){
        fatalError("No NSCoding")
    }
}
