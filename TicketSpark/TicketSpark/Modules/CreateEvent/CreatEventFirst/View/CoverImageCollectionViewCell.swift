//
//  CoverImageCollectionViewCell.swift
//  TicketSpark
//
//  Created by Apple on 05/03/24.
//

import UIKit

class CoverImageCollectionViewCell: UICollectionViewCell, ReusableView {
    
    let identifier = CoverImageCollectionViewCell.defaultReuseIdentifier
    
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
