//
//  QiitaInfoTableViewCell.swift
//  qiitaAPIClientApp
//
//  Created by 宮倉宗平 on 2018/09/24.
//  Copyright © 2018年 Sohei Miyakura. All rights reserved.
//

import UIKit

class QiitaInfoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
