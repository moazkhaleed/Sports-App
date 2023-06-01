//
//  FavouritesViewController.swift
//  Sports-App
//
//  Created by Moaz Khaled on 20/05/2023.
//

import CoreData
import Reachability
import UIKit

class FavouritesVC: UIViewController {
    @IBOutlet var tableView: UITableView!
    
    var currentLeague = League()
    
    var favoriteLeagues: [League] = []
    var segueTemp: League?
    
    var favoritesVM : FavoritesVM?
    
    let reachability: Reachability = Reachability.forInternetConnection()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        tableView.delegate = self
        tableView.dataSource = self
        
        favoritesVM = FavoritesVM(databaseManager: DatabaseManager.getInstance())
        favoriteLeagues = favoritesVM?.getFavorites() ?? []
        
        let nib = UINib(nibName: "CustomTableCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "leagueCell")
        tableView.reloadData()
    }

    override func viewWillAppear(_ animated: Bool) {
        // super.viewWillAppear(animated)

        favoriteLeagues = favoritesVM?.getFavorites() ?? []
        tableView.reloadData()
    }
}

//MARK: Cells
extension FavouritesVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteLeagues.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "leagueCell", for: indexPath) as! CustomTableCell


        let temp: League = favoriteLeagues[indexPath.row]
        cell.nameLabel.text = temp.league_name
        cell.countryLabel.text = temp.country_name
        cell.imgView.kf.setImage(with: URL(string: temp.league_logo ?? ""))

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if reachability.isReachable() {
            
            let temp: League = favoriteLeagues[indexPath.row]
            segueTemp = temp
            currentLeague.league_key = segueTemp?.league_key
            currentLeague.league_name = segueTemp?.league_name
            currentLeague.league_logo = segueTemp?.league_logo
            currentLeague.country_name = segueTemp?.country_name
            
            
            performSegue(withIdentifier: "goToDetails", sender: self)
        } else {
            print("Network is not connected\n")
            Utils.showAlert(viewController: self, Title: "No Internet Connection", Message: "Please, Check the internet connection.")
            tableView.reloadData()
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let teamDetailsVC = segue.destination as? LeagueDetailsVC

        switch segueTemp?.sport {
            case SportsType.football.rawValue:
                teamDetailsVC?.sportType = SportsType.football
            case SportsType.basketball.rawValue:
                teamDetailsVC?.sportType = SportsType.basketball
            case SportsType.cricket.rawValue:
                teamDetailsVC?.sportType = SportsType.cricket
            case SportsType.tennis.rawValue:
                teamDetailsVC?.sportType = SportsType.tennis
            default:
                print("Unexpected Sport Type")
        }
        
        teamDetailsVC?.leagueId = segueTemp?.league_key
        teamDetailsVC?.currentLeague = self.currentLeague
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let alert = UIAlertController(title: "Deleting From Favorites", message: "Are you sure ?", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.destructive, handler: { [self] action in
                
                if self.favoriteLeagues[indexPath.row].league_key != nil {
                    self.favoritesVM?.deleteFavLeague(leagueId: self.favoriteLeagues[indexPath.row].league_key!)
                }
                
                
                self.favoriteLeagues.remove(at: indexPath.row)
                
                    tableView.deleteRows(at: [indexPath], with: .left)
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        
                tableView.reloadData()
        } 
    }
}
