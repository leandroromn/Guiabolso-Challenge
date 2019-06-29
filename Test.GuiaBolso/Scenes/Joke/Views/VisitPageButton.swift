//
//  VisitPageButton.swift
//  Test.GuiaBolso
//
//  Created by Leandro Romano on 28/06/19.
//  Copyright © 2019 Leandro Romano. All rights reserved.
//

import UIKit

class VisitPageButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    fileprivate func setup() {
        backgroundColor = Colors.main
        setTitle(R.string.joke.visit_page_button(), for: .normal)
        setTitleColor(.black, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
        contentEdgeInsets = UIEdgeInsets(top: 14, left: 0, bottom: 14, right: 0)
        layer.cornerRadius = 24
        layer.borderWidth = 2.0
        layer.borderColor = Colors.darkYellow.cgColor
    }

}
