//
//  QueueManager.swift
//  CandySpaceIOSTechnicalTask
//
//  Created by YORK CHAN on 12/3/2022.
//

import Foundation

class QueueManager {
    
    lazy var queue: OperationQueue = {
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 6
        return queue;
    }()
    
    static let shared = QueueManager()
    
    func addOperation(_ operation: Operation) {
        queue.addOperation(operation)
    }
    
    func addOperations(_ operations: [Operation]) {
        queue.addOperations(operations, waitUntilFinished: true)
    }
}
