//
//  PastImageCollectionViewCell.swift
//  TicketSpark
//
//  Created by Apple on 06/03/24.
//

import UIKit

class PastImageCollectionViewCell: UICollectionViewCell, ReusableView {
    
    let identifier = PastImageCollectionViewCell.defaultReuseIdentifier
    
    @IBOutlet weak var additionalImage: UIImageView!
    @IBOutlet weak var btnDeleteCoverImage: UIButton!
    
    func setData(indexPath: IndexPath, imgData: Data?) {
        let index = indexPath.row
        self.btnDeleteCoverImage.tag = indexPath.row
        if let data = imgData {
            self.additionalImage.image = UIImage(data: data)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
