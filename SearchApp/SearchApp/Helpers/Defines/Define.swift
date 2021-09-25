//
//  Define.swift
//  SearchApp
//
//  Created by Haider on 25/09/21.
//

import Foundation

enum SetupKeys: String {
    case clientId = "MjM1NDczMzl8MTYzMjU1NDc5MC44MjIwMjYz"
    case secret = "48e65eb228ac02e3ec82eb17ab0a4f23bc8050f36e17b7a774544b57d1dcd1c8"
}

enum Apis: String {
    case baseUrl = "https://api.seatgeek.com/2/"
    case eventsApi = "events"
}

enum AppGenerals: String {
    
    case serverUTCDateFormat = "yyyy-MM-dd'T'HH:mm:ss"
    case dateFormat1 = "EEEE, d MM yyyy hh:mm a"
}
