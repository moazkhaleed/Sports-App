//
//  ViewController.swift
//  Sports-App
//
//  Created by Moaz Khaled on 20/05/2023.
//

import Kingfisher
import UIKit
import Reachability

// Table Item
struct Sport {
    var sportName : String
    var sportّImage : String
    var sportType: SportsType
}


class SportsVC: UIViewController {
    @IBOutlet var SportsCollectionView: UICollectionView!
    var sports = [Sport]()
//    var sportsAPI: [String]?
    var reachability:Reachability!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SportsCollectionView.dataSource = self
        SportsCollectionView.delegate = self
        
        
        sports.append(Sport(sportName: "FootBall", sportّImage: SportsType.football.rawValue,sportType: SportsType.football))
        sports.append(Sport(sportName: "BasketBall", sportّImage: SportsType.basketball.rawValue,sportType: SportsType.basketball))
        sports.append(Sport(sportName: "Cricket", sportّImage: SportsType.cricket.rawValue,sportType: SportsType.cricket))
        sports.append(Sport(sportName: "Tennis", sportّImage: SportsType.tennis.rawValue,sportType: SportsType.tennis))
        
        reachability = Reachability.forInternetConnection()
        
        let nib = UINib(nibName: "CustomCVCell", bundle: nil)
        SportsCollectionView.register(nib, forCellWithReuseIdentifier: "cell")

        SportsCollectionView.reloadData()
    }

    override func viewWillAppear(_ animated: Bool) {
        SportsCollectionView.reloadData()
    }
}

extension SportsVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sports.count 
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCVCell
        
        cell.sportName.text = sports[indexPath.row].sportName
        
        cell.sportsImageView.image = UIImage(named: sports[indexPath.row].sportّImage)

        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (SportsCollectionView.frame.width / 2) - 8, height: SportsCollectionView.frame.height / 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if reachability.isReachable(){
            let leaguesVC = self.storyboard?.instantiateViewController(withIdentifier: "leaguesStoryboard") as! LeaguesViewController
            
            leaguesVC.sportType = sports[indexPath.row].sportType
            navigationController?.pushViewController(leaguesVC, animated: true)

            
            
        }else{
            Utils.showAlert(viewController: self, Title: "No Internet Connection", Message: "Please Check the internet connection.")
        }
        
        //performSegue(withIdentifier: "goToLeagues", sender: self)
        //        let goto = UIStoryboardSegue(identifier: "Main", source: self, destination: leaguesVC) {
        //            leaguesVC.SportID = self.sportsAPI?[indexPath.row] ?? ""
        //        }
        //        goto.perform()
        //        performSegue(withIdentifier: goto, sender: self)
    }
    
    
    
    
    
}


