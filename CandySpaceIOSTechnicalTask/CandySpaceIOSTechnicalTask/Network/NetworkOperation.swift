//
//  NetworkOperation.swift
//  CandySpaceIOSTechnicalTask
//
//  Created by YORK CHAN on 12/3/2022.
//

import Foundation

class NetworkOperation<T:Any>: Operation {
    
    /// The completionHandler that is run when the operation is complete
    var completionHandler: ((_ result: Result<T, NetworkError>) -> Void)?
    
    /// Stte stored as an enum
    private enum State: String {
        case ready = "isReady"
        case executing = "isExecuting"
        case finished = "isFinished"
    }
    
    private var state = State.ready {
        willSet {
            willChangeValue(forKey: newValue.rawValue)
            willChangeValue(forKey: state.rawValue)
        }
        didSet {
            didChangeValue(forKey: oldValue.rawValue)
            didChangeValue(forKey: state.rawValue)
        }
    }
    
    override var isReady: Bool {
        return super.isReady && state == .ready
    }
    
    override var isExecuting: Bool {
        return state == .executing
    }
    
    override var isFinished: Bool {
        return state == .finished
    }
    
    override var isAsynchronous: Bool {
        return true
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
        DispatchQueue.main.async { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.finish()
            if !weakSelf.isCancelled {
                weakSelf.completionHandler?(result)
            }
        }
    }
    
    /// Cancels the Operation
    override func cancel() {
        super.cancel()
        finish()
    }
}
