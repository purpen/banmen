//
//  THNNoNetConnectionView.swift
//  banmen
//
//  Created by dong on 2017/10/24.
//  Copyright © 2017年 banmen. All rights reserved.
//

import UIKit

class THNNoNetConnectionView: UIView {

    @IBOutlet weak var reFreshBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.reFreshBtn.layer.masksToBounds = true
        self.reFreshBtn.layer.cornerRadius = 2
    }
    
}
