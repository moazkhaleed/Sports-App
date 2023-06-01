//
//  DBManager.swift
//  Sports-App
//
//  Created by Moaz Khaled on 21/05/2023.
//

import CoreData
import Foundation
import UIKit

class DatabaseManager: DatabaseManagerProtocol {
        
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let managedContext: NSManagedObjectContext!
    private let entity: NSEntityDescription!

    private static var coreDataObj: DatabaseManager?
    
    public static func getInstance() -> DatabaseManager {
        if let instance = coreDataObj {
            return instance

        } else {
            coreDataObj = DatabaseManager()
            return coreDataObj!
        }
    }

    private init() {
        managedContext = appDelegate.persistentContainer.viewContext
        entity = NSEntityDescription.entity(forEntityName: "Leagues", in: managedContext)
    }

    func saveData(favoriteLeague: League, sportId: String) {
        guard let entity = NSEntityDescription.entity(forEntityName: "Leagues", in: managedContext) else { return }
        let league = NSManagedObject(entity: entity, insertInto: managedContext)

        league.setValue(favoriteLeague.league_name ?? "", forKey: "name")
        league.setValue(favoriteLeague.country_name ?? "", forKey: "country")
        league.setValue(Int(favoriteLeague.league_key ?? 0), forKey: "id")
        league.setValue(favoriteLeague.league_logo, forKey: "logo")
        league.setValue(sportId, forKey: "sport")
        
        do {
            try managedContext.save()
            print("Saved!")
        } catch{
            print(error.localizedDescription)
        }
    }
    
    func fetchLeagues() -> [League]{
        var leagues = [League]()
        let fetch = NSFetchRequest<NSManagedObject>(entityName: "Leagues")

        do{
            let leaguesArr = try managedContext.fetch(fetch)
            if(leaguesArr.count > 0){
                for i in leaguesArr{
                    let myLeague = League()
                    myLeague.sport = i.value(forKey: "sport") as? String
                    myLeague.league_logo = i.value(forKey: "logo") as? String
                    myLeague.league_key = i.value(forKey: "id") as? Int
                    myLeague.league_name = i.value(forKey: "name") as? String
                    myLeague.country_name = i.value(forKey: "country") as? String
                    leagues.append(myLeague)
                }
                
            }

            

        }catch let error{
            print(error.localizedDescription)
        }

        return leagues

    }
    
    func fetchData() -> [NSManagedObject] {
        var leagues: [NSManagedObject]?
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Leagues")
        do {
            leagues = try managedContext.fetch(fetchRequest)
        } catch let error {
            print(error.localizedDescription)
        }
        return leagues ?? []
    }

    func deleteLeagueFromFavourites(leagueId: Int) {
        let leagues = fetchData()
        for league in leagues {
            if league.value(forKey: "id") as! Int == leagueId{
                managedContext.delete(league)
                try? managedContext.save()
            }
        }
    }
    
    func isLeagueExist(leagueId : Int) -> Bool{

        let fetch = NSFetchRequest<NSManagedObject>(entityName: "Leagues")
        let predicate = NSPredicate(format: "id == %i", leagueId )

        fetch.predicate = predicate
        
        do{
            let leaguesArr = try managedContext.fetch(fetch)
            if(leaguesArr.count > 0){
                print("Fav is exist")
                return true
            }else{
                print("Fav is Not exist")
                return false
            }


        }catch let error{
            print(error.localizedDescription)
        }

        return false
    }
}
