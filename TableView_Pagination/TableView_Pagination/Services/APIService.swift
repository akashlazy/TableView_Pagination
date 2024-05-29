//
//  APIService.swift
//  TableView_Pagination
//
//  Created by Akash Jambhulkar on 28/05/24.
//

import Foundation

struct APIService {
    
    // Singleton instance of APIService
    static let shared = APIService()
    
    // Private initializer to ensure only one instance is created
    private init(){}
    
    // Generic function to make API calls and decode the response
    func call<T: Decodable>(urlRequest: URLRequest, resultType: T.Type, completionHandler: @escaping (_ result: T?) -> Void) {
        
        URLSession.shared.dataTask(with: urlRequest) { (responseData, httpUrlResponse, error) in
            // Check if there is no error and responseData is not nil or empty
            if error == nil, let responseData = responseData, responseData.count != 0 {
                
                let decoder = JSONDecoder()
                do {
                    let result = try decoder.decode(T.self, from: responseData)
                    completionHandler(result)
                } catch {
                    completionHandler(nil)
                }
            } else {
                completionHandler(nil)
            }
        }.resume()
    }
}
