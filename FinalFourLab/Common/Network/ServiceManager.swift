//
//  ServiceManager.swift
//  FinalFourLab
//
//  Created by aarthur on 7/27/21.
//

import Foundation

struct ServiceError: Error, LocalizedError {
    var errorDescription: String?
    init(errorDescription: String?) {
        self.errorDescription = errorDescription
    }
}

/// A singleton for sending service requests.
struct ServiceManager {
    var timeOut: TimeInterval = 15
    private let session: URLSession
    private var task: URLSessionDataTask!
    init(session: URLSession) {
        self.session = session
    }
    
    //MARK: Singleton

    static var sharedService = ServiceManager(session: URLSession.shared)

    /// Request service at urlString.
    /// - Parameters:
    ///   - urlString: Web address of service.
    ///   - completion: Call back to indicate success or failure associated with payload or error.
    @discardableResult
    mutating func startServiceAt(url: URL?, completion:@escaping (Result<Data, ServiceError>)->()) -> URLSessionDataTask? {
        guard let url = url else { return .none }
        var request = URLRequest(url: url)
        request.timeoutInterval = timeOut
        task = session.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                completion(.failure(ServiceError(errorDescription: error?.localizedDescription)))
                return
            }
            completion(.success(data))
        }
        task.resume()
        return task
    }
    
    func cancel() {
        session.invalidateAndCancel()
        task.cancel()
    }
}
