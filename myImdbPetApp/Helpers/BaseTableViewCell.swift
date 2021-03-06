//
//  BaseTableViewCell.swift
//  myImdbPetApp
//
//  Created by Pavlo Tereshchuk on 02.04.22.
//

import UIKit

class BaseTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.layer.cornerRadius = 8
        self.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
