//
//  Leauge.swift
//  RXSwiftDemo
//
//  Created by Abdelrahman Sobhy on 12/3/20.
//  Copyright © 2020 Macbook pro. All rights reserved.
//

import Foundation

struct League : Codable {
    let leagues : [Leagues]
}

class Leagues : Codable {
    var idLeague : String?
    var strLeague : String?
    var strSport : String?
    var strLeagueAlternate: String?
    
}
