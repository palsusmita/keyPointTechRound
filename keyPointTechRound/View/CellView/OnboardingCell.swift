//
//  OnboardingCell.swift
//  keyPointTechRound
//
//  Created by susmita on 09/07/24.
//

import UIKit

class OnboardingCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cardView: CardView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Add shadow and corner radius to create a card effect
//               contentView.layer.cornerRadius = 10
//               contentView.layer.shadowColor = UIColor.black.cgColor
//               contentView.layer.shadowOpacity = 0.1
//               contentView.layer.shadowOffset = CGSize(width: 0, height: 5)
//               contentView.layer.shadowRadius = 10
//               contentView.layer.masksToBounds = false
    }

}
