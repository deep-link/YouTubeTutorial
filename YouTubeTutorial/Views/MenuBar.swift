//
//  MenuBar.swift
//  YouTubeTutorial
//
//  Created by Admin on 7/1/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
class MenuBar: UIView {
    override init(frame: CGRect) {
        super.init(frame:frame)
        backgroundColor = UIColor(red: 230/255, green: 32/255, blue: 31/255, alpha: 1)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
