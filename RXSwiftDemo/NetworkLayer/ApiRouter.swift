//
//  AppDelegate.swift
//  RXSwiftDemo
//
//  Created by Abdelrahman Sobhy on 12/2/20.
//  Copyright © 2020 Macbook pro. All rights reserved.
//

import Foundation
import Alamofire

enum ApiRouter: URLRequestConvertible {
    
    enum Constants{
        static var baseUrl = "https://the-lace-garment-development.herokuapp.com/"
    }
    
    case products
    
    
    var url : URL {
        switch self {
        case .products:
            return URL(string: Constants.baseUrl)!
        }
    }
    
    var method : HTTPMethod {
        switch self {
        case .products:
            return .get
            
        }
    }
    var parameters : [String:Any]{
        switch self {
        default:
            return [:]
        }
    }
    var headers : HTTPHeaders{
        switch self {
        case .products:
            return [:]
        default:
            return [:]
        }
    }
    
    
    func asURLRequest() throws -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.method = method
        urlRequest.headers = headers
        
        switch method {
        case .get, .delete:
            return try URLEncoding.default.encode(urlRequest, with: parameters)
        default:
            return try JSONEncoding.default.encode(urlRequest, with: parameters)
        }
    }
}
