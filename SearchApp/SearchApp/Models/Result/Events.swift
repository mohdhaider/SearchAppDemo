//
//  Events.swift
//  SearchApp
//
//  Created by Haider on 25/09/21.
//

import Foundation

struct Events : Codable {
    
    let id : Int?
    let title : String?
    let venue : Venue?
    let performers : [Performers]?
    let datetime_utc : String?

	enum CodingKeys: String, CodingKey {

        case id = "id"
        case title = "title"
        case venue = "venue"
        case performers = "performers"
        case datetime_utc = "datetime_utc"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        venue = try values.decodeIfPresent(Venue.self, forKey: .venue)
        performers = try values.decodeIfPresent([Performers].self, forKey: .performers)
        datetime_utc = try values.decodeIfPresent(String.self, forKey: .datetime_utc)
	}
}

extension Events: ResultCellContentProtocol {
    
    var imageUrl: String? {
        return performers?.first?.image
    }
    
    var location: String? {
        
        var values = [String]()
        
        if let val = self.venue?.city {
            values.append(val)
        }
        if let val = self.venue?.state {
            values.append(val)
        }
        
        return values.joined(separator: ", ")
    }
    
    var date: String? {
        return Date.utcToLocal(dateStr: datetime_utc, dateFormat: AppGenerals.serverUTCDateFormat.rawValue, targetFormat: AppGenerals.dateFormat1.rawValue)
    }
}
