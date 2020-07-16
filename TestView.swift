//
//  TestView.swift
//  videomenu
//
//  Created by Inpyo Hong on 2020/07/16.
//  Copyright © 2020 Inpyo Hong. All rights reserved.
//

import UIKit

class TestView: UIView {
    
    @IBOutlet weak var testBtn: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
