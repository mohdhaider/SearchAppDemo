//
//  Venue.swift
//  SearchApp
//
//  Created by Haider on 25/09/21.
//

import Foundation
struct Venue : Codable {
    
    let name : String?
    let address : String?
    let city : String?
    let state : String?
    let country : String?
    
	enum CodingKeys: String, CodingKey {

        case name = "name"
        case address = "address"
        case city = "city"
        case state = "state"
        case country = "country"
	}

	init(from decoder: Decoder) throws {
        
		let values = try decoder.container(keyedBy: CodingKeys.self)
        
        name = try values.decodeIfPresent(String.self, forKey: .name)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        city = try values.decodeIfPresent(String.self, forKey: .city)
        state = try values.decodeIfPresent(String.self, forKey: .state)
        country = try values.decodeIfPresent(String.self, forKey: .country)
	}
}
