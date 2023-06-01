//
//  League.swift
//  Sports-App
//
//  Created by Moaz Khaled on 22/05/2023.
//

import Foundation
import CoreData

class LeagueResult: Decodable {
    var success: Int = 0
    var result: [League]?
}

class League: Decodable {
    var league_key: Int?
    var league_name: String?
    var country_name: String?
    var league_logo: String?
    var sport: String?
}


