//
//  ChatTableViewCell.swift
//  capstone
//
//  Created by Alejandro Morales on 2021-12-07.
//

import UIKit

class ChatTableViewCell: UITableViewCell {


 
    @IBOutlet weak var chatImage: UIImageView!
    @IBOutlet weak var chatTittle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
