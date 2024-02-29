//
//  BottomSheetTableViewCell.swift
//  TicketSpark
//
//  Created by Apple on 26/02/24.
//

import UIKit
struct BottomSheetOptionModel {
    let image: UIImage?
    let option: String
}
class BottomSheetTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lbl: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        setUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    func setUI() {
        lbl.font = CustomFont.shared.semiBold(sizeOfFont: 16)
        lbl.textColor = .appBlackTextColor
    }
}
