//
//  FavoritesVM.swift
//  Sports-App
//
//  Created by Moaz Khaled on 29/05/2023.
//

import Foundation
import CoreData


class FavoritesVM{
      
    var bindResultToView : (()->()) = {}
    
    var favArray:[League]!
    
    var databaseManager: DatabaseManagerProtocol!
    
    init( databaseManager: DatabaseManagerProtocol!) {
        
        self.databaseManager = databaseManager
    }
    
    func getFavorites() -> [League]{
        return databaseManager.fetchLeagues()
    }
    

    func deleteFavLeague(leagueId: Int){
        databaseManager.deleteLeagueFromFavourites(leagueId: leagueId)
    }
    
    
    func insertFavLeague(favoriteLeague:League,sportId: String){
        databaseManager.saveData(favoriteLeague: favoriteLeague, sportId: sportId)
    }
    
    func isLeagueExist(league:Int)->Bool{
        return databaseManager.isLeagueExist(leagueId: league)
    }
    
}
