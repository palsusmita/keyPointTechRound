//
//  YouTubeTableViewCell.swift
//  keyPointTechRound
//
//  Created by susmita on 09/07/24.
//

import UIKit

class YouTubeTableViewCell: UITableViewCell {

    @IBOutlet weak var youTubeImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.font = UIFont(name: "Helvetica-Bold", size: 15.0)
        titleLabel.text = "youtube title"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
