//
//  SwitchCell.swift
//  GithubDemo
//
//  Created by Siraj Zaneer on 2/11/17.
//  Copyright © 2017 codepath. All rights reserved.
//

import UIKit

class SwitchCell: UITableViewCell {
    weak var delegate: SwitchCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func onFilter(_ sender: Any) {
        self.delegate?.didSwitch()
        print("hi")
    }
}
