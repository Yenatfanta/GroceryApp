//
//  Video.swift
//  GroceryApp
//
//  Created by Yenat Feyyisa on 3/17/25.
//

import Foundation
struct Video: Decodable {
    let url: String
    enum CodingKeys: String, CodingKey {
        case url = "strYoutube"
    }
}
