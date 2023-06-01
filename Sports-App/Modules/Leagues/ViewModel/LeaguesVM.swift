//
//  LeaguesVM.swift
//  Sports-App
//
//  Created by Moaz Khaled on 24/05/2023.
//

import Foundation

class LeaguesVM {
    // leagues
    
    var networkService : NetworkServiceProtocol?
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    var bindLeaguesToVC: (() -> Void) = {}
    var leagues: [League]? {
        didSet {
            bindLeaguesToVC()
        }
    }

    func getLeagues(sportType: SportsType) {
        let url  = URLGenerator(sportType: sportType,methodType: .Leagues).toString()
        
        networkService?.fetchData(url: url) { [weak self] (root:LeagueResult?, err) in
            self?.leagues = root?.result ?? []
        }
    }
    
}
