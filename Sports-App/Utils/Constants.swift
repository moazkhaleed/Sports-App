//
//  Constants.swift
//  Sports-App
//
//  Created by Moaz Khaled on 21/05/2023.
//

import Foundation

struct Constants{
    static let APIkey = "30e9b34aa8e9d2858590f907883b568e20dd4d716d9673603cb3a8a662547e86"
    
}


enum SportsType:String{
    case football = "football"
    case basketball = "basketball"
    case cricket = "cricket"
    case tennis = "tennis"
}


enum MethodType:String{
    case Leagues = "Leagues"
    case Fixtures = "Fixtures"
    case Livescore = "Livescore"
    case Teams = "Teams"
}
