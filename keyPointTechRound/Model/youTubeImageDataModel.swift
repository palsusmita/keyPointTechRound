//
//  youTubeImageDataModel.swift
//  keyPointTechRound
//
//  Created by susmita on 09/07/24.
//

import Foundation

struct youTubeImageDataModel: Decodable {
    let id: String
    let title: String
    let thumbnailUrl: String
    let duration: String
    let uploadTime: String
    let views: String
    let author: String
    let videoUrl: String
    let description: String
    let subscriber: String
    let isLive: Bool
}
