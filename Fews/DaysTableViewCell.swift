//
//  DaysTableViewCell.swift
//  Fews
//
//  Created by Audric Pandelé on 30/01/2016.
//  Copyright © 2016 Audric Pandelé. All rights reserved.
//

import UIKit

class DaysTableViewCell: UITableViewCell {
    var daysForJson: String!
    
    @IBOutlet weak var daysLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }


}
