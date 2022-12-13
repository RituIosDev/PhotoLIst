//
//  Photos.swift
//  LightSpeedSample
//
//  Created by Ritu on 2022-12-08.
//

import Foundation

struct Photos: Codable{
    var id: String?
    var author: String?
    var width: Int?
    var height: Int?
    var url: String?
    var download_url: String?
    var imageData: Data?

    enum CodingKeys: String, CodingKey{
        case id = "id"
        case author = "author"
        case width = "width"
        case height = "height"
        case url = "url"
        case download_url = "download_url"
    }
}
