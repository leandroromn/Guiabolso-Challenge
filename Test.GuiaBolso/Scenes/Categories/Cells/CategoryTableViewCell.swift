//
//  CategoryTableViewCell.swift
//  Test.GuiaBolso
//
//  Created by Leandro Romano on 27/06/19.
//  Copyright © 2019 Leandro Romano. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    static let identifier = "categoryCell"
    
    @IBOutlet weak var categoryNameLabel: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        accessoryType = .disclosureIndicator
    }
    
}
