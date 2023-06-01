//
//  Constants.swift
//  SportSwift
//
//  Created by Moaz Khaled on 21/05/2023.
//

import Foundation

class URLGenerator{
    static let BASE_URL:String = "https://apiv2.allsportsapi.com/"
    static let API_KEY = "30e9b34aa8e9d2858590f907883b568e20dd4d716d9673603cb3a8a662547e86"
    
    private var url:String = ""
    
    init(){}
    
    init(sportType:SportsType,methodType:MethodType){
        appendBaseURL(base: URLGenerator.BASE_URL)
        appendSportType(sportType:sportType)
        appendAPIKey(APIkey: URLGenerator.API_KEY)
        appendMethodType(methodType: methodType)
    }
    
   
    func appendBaseURL(base:String) -> URLGenerator{
        url.append(base)
        return self
    }
    
    func appendSportType(sportType:SportsType) -> URLGenerator{
        url.append(sportType.rawValue)
        return self
    }
    
    func appendAPIKey(APIkey:String) -> URLGenerator{
        url.append("?APIkey=\(APIkey)")
        return self
    }
    
    
    func appendMethodType(methodType:MethodType) -> URLGenerator{
        url.append("&met=\(methodType.rawValue)")
        return self
    }
    
    
    func appendDateFromTo(isOld:Bool)->URLGenerator{
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "en_US")

        let currentDate = dateFormatter.string(from: date)
        
        var dateComponent = DateComponents()
        dateComponent.year = isOld ? -1 : 1
        let targetTimeDate = Calendar.current.date(byAdding: dateComponent, to: date)


        let targetDate = dateFormatter.string(from: targetTimeDate!)

        url.append("&from=\(isOld ? targetDate : currentDate)&to=\(isOld ? currentDate : targetDate)")
        return self
    }
    
    func appendLeagueID(id:Int)->URLGenerator{
        
        url.append("&leagueId=\(id)")
        return self
    }
    
    func appendTeamID(id:Int)->URLGenerator{
        
        url.append("&teamId=\(id)")
        return self
    }
    
    
    func toString()->String{
        return url
    }
    
    func toURL()->URL!{
        return URL(string: url)!
    }
    
}

