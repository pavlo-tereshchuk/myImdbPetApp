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

extension UIView {
    
    func applyShadow (cornerRadius: CGFloat) {
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = false
        self.layer.shadowRadius = 16.0
        self.layer.shadowOpacity = 0.10
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize (width: 0, height: 5)
//        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 0.5
    }
}
