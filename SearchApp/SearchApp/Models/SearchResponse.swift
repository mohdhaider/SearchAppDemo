//
//  SearchResponse.swift
//  SearchApp
//
//  Created by Haider on 25/09/21.
//

import Foundation

struct SearchResponse: Codable {

    var events : [Events]?
    var meta : Meta?

    enum CodingKeys: String, CodingKey {

        case events = "events"
        case meta = "meta"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        events = try values.decodeIfPresent([Events].self, forKey: .events)
        meta = try values.decodeIfPresent(Meta.self, forKey: .meta)
    }
    
    mutating func clearContent() {
        events = nil
        meta = nil
    }
}
