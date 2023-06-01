//
//  LeagueDetailsViewController.swift
//  Sports-App
//
//  Created by Moaz Khaled on 24/05/2023.
//

import CoreData
import Foundation
import UIKit

class LeagueDetailsVC: UIViewController {
    @IBOutlet var resultsCollectionView: UICollectionView!
    @IBOutlet var teamsCollectionView: UICollectionView!
    @IBOutlet var eventsCollectionView: UICollectionView!
    @IBOutlet var favorite_btn: UIBarButtonItem!
    
    var teams: [Teams] = []
    var events: [Event] = []
    var results: [Result] = []
    
    var leagueId: Int?
    var sportType: SportsType?
    var league_country: String?
    
    
    var leagueVM : LeagueDetailsVM?
    // var isLiked = UserDefaults.standard
    
    var isFavorite = false
    var currentLeague = League()
    
    var favorites: [League] = []
    
    var rightButton: UIBarButtonItem?
    
    let indicator = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
        
        leagueVM = LeagueDetailsVM(networkService: NetworkService(), databaseManager: DatabaseManager.getInstance())
        
        
        // MARK: RegisterCells
        
        let eventNib = UINib(nibName: "EventCVCell", bundle: nil)
        let resultNib = UINib(nibName: "ResultCVCell", bundle: nil)
        let teamNib = UINib(nibName: "TeamCVCell", bundle: nil)
        resultsCollectionView.register(resultNib, forCellWithReuseIdentifier: "resultCell")
        eventsCollectionView.register(eventNib, forCellWithReuseIdentifier: "eventCell")
        teamsCollectionView.register(teamNib, forCellWithReuseIdentifier: "teamCell")
        
        // MARK: Fav Btn
        
        rightButton = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: self, action: #selector(saveToCoreData))
        navigationItem.rightBarButtonItem = rightButton
        
        // MARK: CoreData
        
        favorites = leagueVM?.getFavorites() ?? []
        
        // MARK: FetchData
        
        
        indicator.center = view.center
        view.addSubview(indicator)
        indicator.startAnimating()
        
        leagueVM?.getTeams(leagueId: leagueId ?? 177, sportType: sportType ?? SportsType.football)
        
        leagueVM?.getResults(leagueId: leagueId ?? 177, sportType: sportType ?? SportsType.football)
        
        leagueVM?.getEvents(leagueId: leagueId ?? 177, sportType: sportType ?? SportsType.football)
        
        leagueVM?.bindTeamsToLeagueDVC = { () in
            self.renderTeams()
        }
        
        leagueVM?.bindResultsToLeagueDVC = { () in
            self.renderResults()
        }
        
        leagueVM?.bindEventsToLeagueDVC = { () in
            self.renderEvents()
        }
        
        checkFavouriteLeague()
        
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(dismissVC))
        swipe.direction = .down
        
        view.addGestureRecognizer(swipe)
    }
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
    
    //MARK: Save_Btn
    @objc func saveToCoreData() {
        if rightButton?.image == UIImage(systemName: "heart.fill") {
            showAlert(Title: "Deleting From Favorites", Message: "Are you sure ?")
        } else {
            
            leagueVM?.insertFavLeague(favoriteLeague: currentLeague, sportId: sportType?.rawValue ?? "")
            
            
            rightButton?.image = UIImage(systemName: "heart.fill")
            Utils.showToastMessage(view:view, message: "Added Successfuly", color: .systemBlue)
        }
        viewWillAppear(false)
    }
    
}

extension LeagueDetailsVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    // MARK: Delegates

    func setDelegates() {
        resultsCollectionView.dataSource = self
        resultsCollectionView.delegate = self

        eventsCollectionView.dataSource = self
        eventsCollectionView.delegate = self

        teamsCollectionView.delegate = self
        teamsCollectionView.dataSource = self
    }

    // MARK: Number of Cells

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
            case eventsCollectionView:
                return events.count

            case resultsCollectionView:
                return results.count

            case teamsCollectionView:
                return teams.count

            default:
                return 1
        }
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }

    // MARK: Dimensions

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
            case eventsCollectionView:
                return CGSize(width: eventsCollectionView.frame.width - 16, height: eventsCollectionView.frame.height - 20)
            case resultsCollectionView:
                return CGSize(width: resultsCollectionView.frame.width - 16, height: resultsCollectionView.frame.height / 10)
            case teamsCollectionView:
                return CGSize(width: teamsCollectionView.frame.width / 3, height: teamsCollectionView.frame.height - 20)
            default:
                return CGSize(width: 100, height: 100)
        }
    }

    // MARK: Cells

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
            case eventsCollectionView:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "eventCell", for: indexPath) as! EventCVCell
                
                switch sportType?.rawValue {
                case SportsType.basketball.rawValue,SportsType.cricket.rawValue:
                        cell.awayImageE.kf.setImage(with: URL(string: events[indexPath.row].event_away_team_logo ?? "https://png.pngtree.com/png-vector/20190917/ourmid/pngtree-not-found-circle-icon-vectors-png-image_1737851.jpg"))
                        cell.homeImageE.kf.setImage(with: URL(string: events[indexPath.row].event_home_team_logo ?? "https://png.pngtree.com/png-vector/20190917/ourmid/pngtree-not-found-circle-icon-vectors-png-image_1737851.jpg"))
                    default:
                        cell.awayImageE.kf.setImage(with: URL(string: events[indexPath.row].away_team_logo ?? "https://png.pngtree.com/png-vector/20190917/ourmid/pngtree-not-found-circle-icon-vectors-png-image_1737851.jpg"))
                        cell.homeImageE.kf.setImage(with: URL(string: events[indexPath.row].home_team_logo ?? "https://png.pngtree.com/png-vector/20190917/ourmid/pngtree-not-found-circle-icon-vectors-png-image_1737851.jpg"))
                }
                
                switch sportType?.rawValue {
                    case SportsType.cricket.rawValue:
                        cell.dateLabel.text = events[indexPath.row].event_date_start
                    default:
                        cell.dateLabel.text = events[indexPath.row].event_date
                }
                
                cell.timeLabel.text = events[indexPath.row].event_time

                return cell
                
            case teamsCollectionView:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "teamCell", for: indexPath) as! TeamCVCell
                cell.teamLabel.text = teams[indexPath.row].team_name
                cell.teamLogo.kf.setImage(with: URL(string: teams[indexPath.row].team_logo ?? "https://png.pngtree.com/png-vector/20190917/ourmid/pngtree-not-found-circle-icon-vectors-png-image_1737851.jpg"))
    //                cell.teamLabel.text = "Team +"
    //                cell.teamLogo.image = UIImage(named: "SplashLogo")
                
                return cell
                
            case resultsCollectionView:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "resultCell", for: indexPath) as! ResultCVCell
                switch sportType?.rawValue {
                    case SportsType.basketball.rawValue, SportsType.cricket.rawValue:
                        cell.awayImage.kf.setImage(with: URL(string: results[indexPath.row].event_away_team_logo ?? "https://png.pngtree.com/png-vector/20190917/ourmid/pngtree-not-found-circle-icon-vectors-png-image_1737851.jpg"))
                        cell.homeImage.kf.setImage(with: URL(string: results[indexPath.row].event_home_team_logo ?? "https://png.pngtree.com/png-vector/20190917/ourmid/pngtree-not-found-circle-icon-vectors-png-image_1737851.jpg"))
                    default:
                        cell.awayImage.kf.setImage(with: URL(string: results[indexPath.row].away_team_logo ?? "https://png.pngtree.com/png-vector/20190917/ourmid/pngtree-not-found-circle-icon-vectors-png-image_1737851.jpg"))
                        cell.homeImage.kf.setImage(with: URL(string: results[indexPath.row].home_team_logo ?? "https://png.pngtree.com/png-vector/20190917/ourmid/pngtree-not-found-circle-icon-vectors-png-image_1737851.jpg"))
                }
                
                switch sportType?.rawValue {
                    case SportsType.cricket.rawValue:
                        cell.dateLabel.text = results[indexPath.row].event_date_stop
                        cell.resultLabel.text = (results[indexPath.row].event_home_final_result ?? "") + "\n" + (results[indexPath.row].event_away_final_result ?? "")
                    default:
                        cell.dateLabel.text = results[indexPath.row].event_date
                        cell.resultLabel.text = results[indexPath.row].event_final_result
                }
                
                cell.timeLabel.text = results[indexPath.row].event_time
                return cell
            default:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "default", for: indexPath)
                return cell
        }
    }

    // MARK: Navigation

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
            case teamsCollectionView:
                let teamDetailsVC = self.storyboard?.instantiateViewController(withIdentifier: "teamDetails") as! TeamDetailsVC
                teamDetailsVC.team = teams[indexPath.row]
                teamDetailsVC.league_name = league_country
                teamDetailsVC.sportType = sportType

                teamDetailsVC.modalPresentationStyle = .fullScreen
                present(teamDetailsVC, animated: true)

            default:
                print("Couldn't able to Navigate")
        }
    }
}

// MARK: Rendering

extension LeagueDetailsVC {
    
    func renderTeams() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.teams = self.leagueVM?.teams ?? []
            self.teamsCollectionView.reloadData()
        }
    }

    func renderResults() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.results = self.leagueVM?.results ?? []
            self.resultsCollectionView.reloadData()
            self.indicator.stopAnimating()
            
        }
    }

    func renderEvents() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            self.events = self.leagueVM?.events ?? []
            self.eventsCollectionView.reloadData()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        viewDidLoad()
        resultsCollectionView.reloadData()
        teamsCollectionView.reloadData()
        eventsCollectionView.reloadData()
    }

}

extension LeagueDetailsVC {
    
    // MARK: CoreData
    func checkFavouriteLeague() {
        guard let leagueId = leagueId else{
            return
        }
        guard let leagueVM = leagueVM else{
            return
        }
        
        if leagueVM.isLeagueExist(leagueId: leagueId) {
            rightButton?.image = UIImage(systemName: "heart.fill")
            print("yes")
        } else {
            print("No")
        }

    }
    
    // MARK: Alert
    func showAlert(Title: String, Message: String) {
        guard let leagueId = leagueId else{
            return
        }
        let alert = UIAlertController(title: Title, message: Message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.destructive, handler: { [self] action in
            self.leagueVM?.deleteFavLeague(leagueId: leagueId)
            self.rightButton?.image = UIImage(systemName: "heart")
            Utils.showToastMessage(view: view, message: "Deleted Successfuly", color: .red)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
}
