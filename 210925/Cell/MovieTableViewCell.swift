//
//  MovieTableViewCell.swift
//  210925
//
//  Created by kms on 2021/09/25.
//

import UIKit
import FloatRatingView

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var averageLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var RatingView: FloatRatingView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        RatingView.backgroundColor = .clear
        RatingView.contentMode = .scaleAspectFit
        RatingView.type = .floatRatings
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
