//
//  bannerImageDataModel.swift
//  keyPointTechRound
//
//  Created by susmita on 10/07/24.
//

import Foundation

struct BannerImageDataModel: Codable {
    let title: String
    let imageMobile: String
    let imageDesktop: String
}

struct BannersResponse: Codable {
    let data: [BannerImageDataModel]
}
