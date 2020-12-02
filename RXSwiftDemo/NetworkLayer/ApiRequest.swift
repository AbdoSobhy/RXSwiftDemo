//
//  AppDelegate.swift
//  RXSwiftDemo
//
//  Created by Abdelrahman Sobhy on 12/2/20.
//  Copyright © 2020 Macbook pro. All rights reserved.
//

import Foundation
import Alamofire

class ApiRequest{
    static func apiCall<T : Decodable>(responseModel: T.Type, request : ApiRouter,  completionHandeler: @escaping (Result<T,Error>) -> Void) {
        AF.request(request).responseData { (response : AFDataResponse<Data>) in
            switch response.result{
            case .success(let result):
                do {
                    let obj = try JSONDecoder().decode(T.self, from: result)
                    completionHandeler(.success(obj))
                } catch {
                    completionHandeler(.failure(error))
                }
            case .failure(let error):
                completionHandeler(.failure(error))
            }
        }
    }
}
