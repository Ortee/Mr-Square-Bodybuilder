//
//  RankingTableViewCell.swift
//  Bodybuilder
//
//  Created by Denis Olek on 25.01.2017.
//  Copyright © 2017 BatoregoTeam. All rights reserved.
//

import UIKit

class RankingTableViewCell: UITableViewCell {

    @IBOutlet weak var level: UILabel!
    @IBOutlet weak var place: UILabel!
    @IBOutlet weak var strength: UILabel!
    @IBOutlet weak var name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
