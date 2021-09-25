//
//  Throttler.swift
//  SearchApp
//
//  Created by Haider on 25/09/21.
//

import Foundation

class Throttler: NSObject {

    private let queue: DispatchQueue = DispatchQueue.global(qos: .background)
    
    private var job: DispatchWorkItem = DispatchWorkItem(block: {})
    private var previousRun: Date = Date.distantPast
    private var maxInterval: Double
    
    @objc init(seconds: Double) {
        self.maxInterval = seconds
    }
    
    func throttle(block: @escaping () -> ()) {
        job.cancel()
        job = DispatchWorkItem(){ [weak self] in
            self?.previousRun = Date()
            block()
        }
        let delay = (Date().second(from: previousRun) > maxInterval) ? 0 : maxInterval
        queue.asyncAfter(deadline: .now() + Double(delay), execute: job)
    }
}

private extension Date {
    func second(from referenceDate: Date) -> Double {
        return self.timeIntervalSince(referenceDate).rounded()
    }
}
