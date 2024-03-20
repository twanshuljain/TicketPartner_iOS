//
//  TicketTypeCollectionVC.swift
//  TicketSpark
//
//  Created by Apple on 22/02/24.
//

import UIKit

class TicketTypeCollectionVC: UICollectionViewCell {
    @IBOutlet weak var lblTicketType: UILabel!
    @IBOutlet weak var viewSelection: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func configureCell(data: TicketTypeModel) {
        lblTicketType.font = CustomFont.shared.bold(sizeOfFont: 14)
        lblTicketType.text = data.ticketType
        if data.isSelected {
            viewSelection.layer.cornerRadius = 15
            lblTicketType.textColor = .appBlackTextColor
            viewSelection.backgroundColor = .white
        } else {
            lblTicketType.textColor = .grayTextColor
            viewSelection.backgroundColor = .clear
        }
    }
}
