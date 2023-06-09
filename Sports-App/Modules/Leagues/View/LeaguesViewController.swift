
//
//  LeaguesViewController.swift
//  Sports-App
//
//  Created by Moaz Khaled on 22/05/2023.
//

import Kingfisher
import UIKit

class LeaguesViewController: UIViewController {
    
    @IBOutlet weak var searchbar: UISearchBar! {
        didSet{
            searchbar.delegate = self
        }
    }
    @IBOutlet var leaguesTableView: UITableView! {
        didSet{
            leaguesTableView.delegate = self
            leaguesTableView.dataSource = self
        }
    }
    var leaguesArray: [League]?
    var searchArray: [League]?
    
    var leagueVM: LeaguesVM?
    
    var cuurentLeague:League?
    var sportType: SportsType?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: "CustomTableCell", bundle: nil)
        leaguesTableView.register(nib, forCellReuseIdentifier: "leagueCell")

        let indicator = UIActivityIndicatorView(style: .large)
        indicator.center = view.center
        view.addSubview(indicator)
        indicator.startAnimating()

        leagueVM = LeaguesVM(networkService: NetworkService())
        leagueVM?.getLeagues(sportType: sportType ?? SportsType.football)
        leagueVM?.bindLeaguesToVC = { () in
            self.renderView()
            indicator.stopAnimating()
            
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        leaguesTableView.reloadData()
    }
}

extension LeaguesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        leaguesArray?.count ?? 20
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "leagueCell", for: indexPath) as! CustomTableCell

        cell.imgView?.kf.setImage(with: URL(string: (leaguesArray?[indexPath.row].league_logo) ?? ""),placeholder: UIImage(named: "logo"))
        cell.nameLabel.text = leaguesArray?[indexPath.row].league_name
        cell.countryLabel.text = leaguesArray?[indexPath.row].country_name
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch self.sportType {
        case .tennis:
                showAlert(Title: "On Preparing League", Message: "Sorry for this issue, Hope a nice day for You")
            default:
                cuurentLeague = leaguesArray?[indexPath.row]
                performSegue(withIdentifier: "goToDetails", sender: self)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let leagueDetailsVC = segue.destination as? LeagueDetailsVC
        leagueDetailsVC?.sportType = self.sportType
        leagueDetailsVC?.leagueId = self.cuurentLeague?.league_key
        leagueDetailsVC?.currentLeague = self.cuurentLeague!
    }
}

extension LeaguesViewController {
    func renderView() {
        DispatchQueue.main.async {
            self.leaguesArray = self.leagueVM?.leagues ?? []
            self.searchArray = self.leagueVM?.leagues ?? []
            self.leaguesTableView.reloadData()
        }
    }
    
    func showAlert(Title: String, Message: String) {
        let alert = UIAlertController(title: Title, message: Message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
}
extension LeaguesViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        leaguesArray = []
        if searchText == "" {
            leaguesArray = searchArray
        }
        for league in searchArray ?? [] {
            if league.league_name!.uppercased().contains(searchText.uppercased()){
                leaguesArray?.append(league)
            }
        }
        self.leaguesTableView.reloadData()
    }
}
