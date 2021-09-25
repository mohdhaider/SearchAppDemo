//
//  NetworkManager.swift
//  SearchApp
//
//  Created by Haider on 25/09/21.
//

import Foundation

struct NetworkManager {
    
    func fetchSearch(_ interactor:NetworkInteractor<SearchRequest>,_ info: SearchRequest, completionBlock: @escaping NetworkRequestCompletion) {
        
        interactor.request(info) { (data, response, error) in
            
            completionBlock(data, response, error)
        }
    }
}
