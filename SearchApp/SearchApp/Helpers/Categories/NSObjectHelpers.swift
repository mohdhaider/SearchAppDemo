//
//  NSObjectHelpers.swift
//  SearchApp
//
//  Created by Haider on 25/09/21.

//

import Foundation

extension NSObject {
    
    func moveToMainThread(_ block:(() -> Void)?){
        
        if Thread.isMainThread {
            block?()
        } else {
            DispatchQueue.main.async {
                block?()
            }
        }
    }
}
