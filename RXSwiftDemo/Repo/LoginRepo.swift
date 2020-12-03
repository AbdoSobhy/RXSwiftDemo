//
//  LoginRepo.swift
//  RXSwiftDemo
//
//  Created by Abdelrahman Sobhy on 12/2/20.
//  Copyright © 2020 Macbook pro. All rights reserved.
//

import Foundation
protocol AuthenticationsRepo {
    func login(username: String, Password: String, completionHandeler: @escaping (Result<Login,Error>)->Void)
}

class AuthenticationsRepoImpl: AuthenticationsRepo {
    func login(username: String, Password: String, completionHandeler: @escaping (Result<Login, Error>)->Void){
        ApiRequest.apiCall(responseModel: Login.self, request: .login(username: username, password: Password)) { (response) in
            switch response{
            case .success(let login):
                completionHandeler(.success(login))
            case .failure(let error):
                completionHandeler(.failure(error))
            }
        }
    }
}
