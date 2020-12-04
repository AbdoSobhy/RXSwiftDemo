//
//  LeaugeRepo.swift
//  RXSwiftDemo
//
//  Created by Abdelrahman Sobhy on 12/3/20.
//  Copyright © 2020 Macbook pro. All rights reserved.
//

import Foundation
protocol LeaugeRepo {
    func getLeauge(completionHandeler: @escaping (Result<[Leagues], Error>)->Void)
    }
    
    class LeaugeRepoImpl: LeaugeRepo {
        func getLeauge(completionHandeler: @escaping (Result<[Leagues], Error>)->Void){
            ApiRequest.apiCall(responseModel: League.self, request: .getLeauges) { response in
                switch response {
                case .success(let leauge):
                    completionHandeler(.success(leauge.leagues))
                case .failure(let error):
                    completionHandeler(.failure(error))
                }
            }
            
        }
}
