//
//  Meta.swift
//  SearchApp
//
//  Created by Haider on 25/09/21.
//

import Foundation

struct Meta : Codable {
	let total : Int?
	let page : Int?
	let per_page : Int?

	enum CodingKeys: String, CodingKey {

		case total = "total"
		case page = "page"
		case per_page = "per_page"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		total = try values.decodeIfPresent(Int.self, forKey: .total)
		page = try values.decodeIfPresent(Int.self, forKey: .page)
		per_page = try values.decodeIfPresent(Int.self, forKey: .per_page)
	}
}
