//
//  Performers.swift
//  SearchApp
//
//  Created by Haider on 25/09/21.
//

import Foundation

struct Performers : Codable {
    
    let id : Int?
    let name : String?
    let image : String?
    


	enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
        case image = "image"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        image = try values.decodeIfPresent(String.self, forKey: .image)
	}
}
