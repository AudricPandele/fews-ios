//
//  TextCell.swift
//  Fews
//
//  Created by Audric Pandelé on 15/12/2015.
//  Copyright © 2015 Audric Pandelé. All rights reserved.
//

import UIKit

class TextCell: UITableViewCell {

    @IBOutlet weak var articleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
