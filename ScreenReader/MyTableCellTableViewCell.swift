//
//  MyTableCellTableViewCell.swift
//  ScreenReader
//
//  Created by Julianna Yee on 11/1/17.
//  Copyright © 2017 TravisGayle. All rights reserved.
//

import UIKit

class MyTableCellTableViewCell: UITableViewCell {

    @IBOutlet weak var Recipe: UILabel!
    @IBOutlet weak var Description: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
