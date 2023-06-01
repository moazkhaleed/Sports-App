//
//  CoreDataProtocols.swift
//  Sports-App
//
//  Created by Moaz Khaled on 21/05/2023.
//

import CoreData
import Foundation

protocol DatabaseManagerProtocol {
    
    func saveData(favoriteLeague: League, sportId: String)
    
    func fetchData() -> [NSManagedObject]
    func fetchLeagues() -> [League]

    func deleteLeagueFromFavourites(leagueId: Int)
    
    func isLeagueExist(leagueId : Int) -> Bool
    
}
