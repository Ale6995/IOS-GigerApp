//
//  customTableViewCell.swift
//  capstone
//
//  Created by Alejandro Morales on 2021-11-29.
//

import UIKit

class customTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let gradient:CAGradientLayer = CAGradientLayer()
        gradient.frame.size = self.bounds.size
        gradient.colors = [UIColor.init(named: "CardColor")!.cgColor,UIColor.init(named: "CardColorEnd")!.cgColor] //Or any colors
            self.layer.insertSublayer(gradient, at: 0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
