//
//  LabelTableViewCell.swift
//  sieveOfEratosthenes
//
//  Created by Arunjot Singh on 12/2/16.
//  Copyright © 2016 Arunjot Singh. All rights reserved.
//

import UIKit

class LabelTableViewCell: UITableViewCell {
    
    @IBOutlet var numLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
