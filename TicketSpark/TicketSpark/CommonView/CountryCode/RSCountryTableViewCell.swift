//
//  RSCountryTableViewCell.swift
//  TicketSpark
//
//  Created by Apple on 16/02/24.
//

import UIKit

class RSCountryTableViewCell: UITableViewCell {
    @IBOutlet var imgCountryFlag: UIImageView!
    @IBOutlet var lblCountryName: UILabel!
    @IBOutlet var lblCountryDialCode: UILabel!
    @IBOutlet var imgRadioCheck: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       //imgCountryFlag.setImageCircle()
        imgCountryFlag.layer.cornerRadius = 6.0
        imgCountryFlag.layer.masksToBounds = true
    }
   override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
