//
//  JsonUtility.swift
//  FinalFourLab
//
//  Created by aarthur on 7/27/21.
//

import Foundation

/// Generic struct for parsing json
/// The generic type should be a decodable type that the parser will create and fill
struct JsonUtility<T: Decodable> {

    /// Parse the payload
    /// - Parameters:
    ///   - payload: JSON data
    ///   - ctx: core data context that is passed to the init of the generic type
    /// - Returns: An array of generic type, T, objects, or nil
    static func parseJSON(_ payload: Data?) -> T? {
        guard let payload = payload else { return nil }

        let decoder = JSONDecoder()
        do {
            let decoded = try decoder.decode(T.self, from: payload)
            return decoded
        } catch let error {
            print(error)
        }
        return nil
    }
}
