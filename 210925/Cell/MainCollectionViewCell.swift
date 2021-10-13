//
//  MainCollectionViewCell.swift
//  210925
//
//  Created by kms on 2021/10/13.
//

import UIKit
import FloatRatingView

class MainCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var reserveBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUI()
    }
    
    fileprivate func setUI() {
        imgView.layer.cornerRadius = 20
        imgView.clipsToBounds = true
        
        reserveBtn.layer.cornerRadius = 18
        reserveBtn.clipsToBounds = true
        reserveBtn.layer.borderWidth = 0.5
        reserveBtn.layer.borderColor = UIColor.black.cgColor

//        ratingView.backgroundColor = .clear
//        ratingView.contentMode = .scaleAspectFit
//        ratingView.type = .floatRatings
    }

}
