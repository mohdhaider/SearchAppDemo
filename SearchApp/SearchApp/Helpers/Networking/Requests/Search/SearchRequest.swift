//
//  SearchRequest.swift
//  SearchApp
//
//  Created by Haider on 25/09/21.
//

import Foundation

enum SearchRequest {
    case search(page: Int, searchText: String?)
}

extension SearchRequest : RequestInfo {
    var httpType: HTTPType {
        return .get
    }
    
    var requestURL: URL {
        
        let urlStr = Apis.baseUrl.rawValue + Apis.eventsApi.rawValue
        
        guard let url = URL(string: urlStr) else { fatalError("Unable to configure url") }
        return url
    }
    
    var requestType: RequestFeature {
        
        let headers =  Parameters()
        let bodyParams =  Parameters()
        var urlParams =  Parameters()
        
        switch self {
        case .search(let page, let searchText):
            urlParams["client_id"] = SetupKeys.clientId.rawValue
            urlParams["page"] = page
            urlParams["q"] = searchText ?? ""
        }
        
        return .requestWithParameters(encoding: .urlEncoding, urlParameters: urlParams, bodyParameters: bodyParams, headers: headers)
    }
}
