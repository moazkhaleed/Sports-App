//
//  SportVM.swift
//  Sports-App
//
//  Created by Moaz Khaled on 24/05/2023.
//

import Alamofire
import Foundation

// League Details
class LeagueDetailsVM{
    
    var networkService : NetworkServiceProtocol?
    
    var databaseManager: DatabaseManagerProtocol?
    
    init(networkService : NetworkServiceProtocol, databaseManager: DatabaseManagerProtocol) {
        self.networkService = networkService
        self.databaseManager = databaseManager
    }
    
    var bindTeamsToLeagueDVC: (() -> Void) = {}
    var bindEventsToLeagueDVC: (() -> Void) = {}
    var bindResultsToLeagueDVC: (() -> Void) = {}
    
    var teams: [Teams] = [] {
        didSet {
            bindTeamsToLeagueDVC()
        }
    }
    var events: [Event] = [] {
        didSet {
            bindEventsToLeagueDVC()
        }
    }
    var results: [Result] = [] {
        didSet {
            bindResultsToLeagueDVC()
        }
    }
    
    func getTeams(leagueId:Int,sportType:SportsType) {
        let url = URLGenerator(sportType: sportType,methodType: .Teams)
            .appendLeagueID(id: leagueId)
            .toString()
        
        networkService?.fetchData(url: url) { [weak self] (root:TeamsResult?, err) in
            self?.teams = root?.result ?? []
        }
    }
    
    func getEvents(leagueId:Int,sportType:SportsType) {
        
        let url  = URLGenerator(sportType: sportType,methodType: .Fixtures)
            .appendDateFromTo(isOld: false)
            .appendLeagueID(id: leagueId)
            .toString()
        
        networkService?.fetchData(url: url) { [weak self] (root:EventsResult?, err) in
            self?.events = root?.result ?? []
        }
    }
    
    func getResults(leagueId:Int,sportType:SportsType) {
        let url  = URLGenerator(sportType: sportType,methodType: .Fixtures)
            .appendDateFromTo(isOld: true)
            .appendLeagueID(id: leagueId)
            .toString()
        
        networkService?.fetchData(url: url) { [weak self] (root:ResultsResult?, err) in
            self?.results = root?.result ?? []
        }
    }
    
    
    func getFavorites() -> [League]{
        return databaseManager?.fetchLeagues() ?? []
    }
    
    
    func insertFavLeague(favoriteLeague:League,sportId: String){
        databaseManager?.saveData(favoriteLeague: favoriteLeague, sportId: sportId)
    }

    func deleteFavLeague(leagueId: Int){
        databaseManager?.deleteLeagueFromFavourites(leagueId: leagueId)
    }

    
    func isLeagueExist(leagueId:Int)->Bool{
        return databaseManager?.isLeagueExist(leagueId: leagueId) ?? false
    }
    
}


