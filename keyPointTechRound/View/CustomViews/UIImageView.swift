//
//  UIImageView.swift
//  keyPointTechRound
//
//  Created by susmita on 09/07/24.
//

import UIKit

extension UIImageView {
    
    func loadImage(from url: URL) {
        ImageLoader.shared.loadImage(from: url) { [weak self] image in
            self?.image = image
        }
    }
}
