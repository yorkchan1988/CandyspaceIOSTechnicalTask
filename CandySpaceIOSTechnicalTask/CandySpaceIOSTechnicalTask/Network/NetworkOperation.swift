//
//  NetworkOperation.swift
//  CandySpaceIOSTechnicalTask
//
//  Created by YORK CHAN on 12/3/2022.
//

import Foundation

class NetworkOperation<T:Codable>: Operation {
    
    var completionHandler: ((_ result: Result<T, NetworkError>) -> Void)?
    
    private enum State {
        case ready
        case executing
        case finished
    }
    
    private var state = State.ready
    
    override var isReady: Bool {
        return super.isReady && state == .ready
    }
    
    override var isExecuting: Bool {
        return state == .executing
    }
    
    override var isFinished: Bool {
        return state == .finished
    }
    
    /// Start the NSOperation
    override func start() {
        guard !isCancelled else {
            finish()
            return
        }
        if !isExecuting {
            state = .executing
        }
        main()
    }
    
    /// Move to the finished state
    func finish() {
        if isExecuting {
            state = .finished
        }
    }
    
    /// Called to indicate that the operation is complete, and then call the opional completion handler
    /// - Parameter result: The result type
    func complete(result: Result<T, NetworkError>) {
        finish()
        if !isCancelled {
            DispatchQueue.main.async { [weak self] in
                self?.completionHandler?(result)
            }
        }
    }
    
    /// Cancels the Operation
    override func cancel() {
        super.cancel()
        finish()
    }
}
