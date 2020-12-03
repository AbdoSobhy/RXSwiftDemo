//
//  Login.swift
//  RXSwiftDemo
//
//  Created by Abdelrahman Sobhy on 12/2/20.
//  Copyright © 2020 Macbook pro. All rights reserved.
//

import Foundation

struct Login: Codable {
    let sessionToken: String
    let approved: Bool
    let msg: String
}
