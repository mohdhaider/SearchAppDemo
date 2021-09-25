//
//  SearchViewModel.swift
//  SearchApp
//
//  Created by Haider on 25/09/21.
//

import UIKit

class SearchViewModel: NSObject {

    // MARK:- Variables -
    
    private let interactor: NetworkInteractor<SearchRequest> = NetworkInteractor()
    
    private let networkManager = NetworkManager()
    
    var viewModelCallbacks = BindingBox<Any?>(nil)
    
    private var response: SearchResponse?
    
    private var isFetchingMoreResults = false
    
    // MARK:- Helpers -
    
    private func clearContent() {
        
        response = nil
    }
    
    func getFreshSearchResults(forSearchText text:String?) {
        
        clearContent()
        
        viewModelCallbacks.value = SearchMessages.dataCleared
        
        guard let text = text, !text.isEmpty else {
            return
        }
        
        isFetchingMoreResults = false
        
        networkManager.fetchSearch(interactor, .search(page: 1, searchText: text)) {[weak self] (data, response, error) in
            
            do {
                if let dataAvail = data {
                    
                    let searchResponse = try JSONDecoder().decode(SearchResponse.self, from: dataAvail)
                    
                    self?.response = searchResponse
                    
                    self?.viewModelCallbacks.value = SearchMessages.newDataAvailable
                }
            } catch {
                print("error = \(error)")
                self?.viewModelCallbacks.value = SearchViewModelErrors.dataParsingFailed
            }
        }
    }
    
    func getNextSearchResults(forSearchText text:String?) {
        
        guard !isFetchingMoreResults else {
            return
        }
        
        isFetchingMoreResults = true
        
        guard let text = text, !text.isEmpty else {
            
            isFetchingMoreResults = false
            
            viewModelCallbacks.value = SearchMessages.nextBatchNotPossible
            return
        }
        
        networkManager.fetchSearch(interactor, .search(page: (response?.meta?.page ?? 0) + 1, searchText: text)) {[weak self] (data, response, error) in
            
            if self?.isFetchingMoreResults ?? false {
                
                do {
                    if let dataAvail = data {
                        
                        var searchResponse = try JSONDecoder().decode(SearchResponse.self, from: dataAvail)
                        
                        let temp = self?.response
                        
                        var total = [Events]()
                        
                        if let val = temp?.events {
                            total.append(contentsOf: val)
                        }
                        if let val = searchResponse.events {
                            total.append(contentsOf: val)
                        }
                        
                        searchResponse.events = total
                        
                        self?.response = searchResponse
                        
                        self?.viewModelCallbacks.value = SearchMessages.newDataAvailable
                    }
                } catch {
                    print("error = \(error)")
                    self?.viewModelCallbacks.value = SearchViewModelErrors.dataParsingFailed
                }
                
                self?.isFetchingMoreResults = false
            }
        }
    }
}

// MARK:- Search List Helpers -

extension SearchViewModel {
    
    func totalResults() -> Int {
        return response?.events?.count ?? 0
    }
    
    func resultForIndex(_ index:Int) -> Events? {
        
        if let events = response?.events,
           index < events.count {
           
            return events[index]
        }
        
        return nil
    }
}

enum SearchViewModelErrors: String, Error {
    case dataParsingFailed
}

enum SearchMessages: String {
    case dataCleared
    case nextBatchNotPossible
    case newDataAvailable
}
