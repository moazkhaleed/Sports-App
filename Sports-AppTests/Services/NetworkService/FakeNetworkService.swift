//
//  FakeNetworkService.swift
//  Sports-AppTests
//
//  Created by Moaz Khaled on 30/05/2023.
//

import Foundation
@testable import Sports_App

class FakeNetworkService {

    var shouldReturnError : Bool
    
    let mockLeaguesJSONResponse: String = """
        {
            "success": 1,
            "result": [
                {
                    "league_key": 4,
                    "league_name": "UEFA Europa League",
                    "country_key": 1,
                    "country_name": "eurocups",
                    "league_logo": "https://apiv2.allsportsapi.com/logo/logo_leagues/",
                    "country_logo": null
                },
                {
                    "league_key": 1,
                    "league_name": "European Championship",
                    "country_key": 1,
                    "country_name": "eurocups",
                    "league_logo": null,
                    "country_logo": null
                }
            ]
        }
    """
    
    init(shouldReturnError: Bool) {
        self.shouldReturnError = shouldReturnError
    }
    
    enum ResposeWithError : Error {
        case responseError
    }
    
}


extension FakeNetworkService: NetworkServiceProtocol{
    func fetchData<T>(url: String, complition: @escaping (T?, Error?) -> ()) where T : Decodable {
        let data = Data(mockLeaguesJSONResponse.utf8)
        do {
            let response = try JSONDecoder().decode(T.self, from: data)
            complition(response,nil)
        } catch {
            complition(nil,ResposeWithError.responseError)
        }
    }
    
}

