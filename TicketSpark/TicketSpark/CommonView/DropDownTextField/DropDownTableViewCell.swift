//
//  DropDownTableViewCell.swift
//  Nagad
//
//  Created by Vipin Kumar on 01/09/22.
//

import UIKit

class DropDownTableViewCell: UITableViewCell {
    
    @IBOutlet weak var bankNameTitleLabel: UILabel!
    @IBOutlet weak var radioBtnImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        setFont()
    }

    private func setupUI() {
//        bankNameTitleLabel.font = CustomFont.shared.regular(fontType: .poppins, sizeOfFont: 16)
    }
    
    private func setFont() {
        self.bankNameTitleLabel.font = CustomFont.shared.regular(sizeOfFont: 16.0)
    }
    
    var isSelectedCell: Bool = false {
        didSet {
                radioBtnImageView.image = UIImage(named: isSelectedCell ? "ic_radio_selected" : "ic_radio")
        }
    }
}
