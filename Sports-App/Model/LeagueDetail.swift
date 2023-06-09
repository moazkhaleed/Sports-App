//
//  LeagueDetail.swift
//  Sports-App
//
//  Created by Moaz Khaled on 22/05/2023.
//

import Foundation

//MARK: Events

class Event: Decodable {
    var event_key: Int?
    var event_date: String?
    var event_date_start: String?
    var event_time: String?
    var event_home_team: String?
    var event_away_team: String?
    var event_final_result: String?
    var country_name: String?
    var league_name: String?
    var league_key: Int?
    var league_round: String?
    var league_season: String?
    var event_live: String?
    var event_stadium: String?
    var event_referee: String?
    var home_team_logo: String?
    var event_home_team_logo: String?
    var event_away_team_logo: String?
    var away_team_logo: String?
    var event_country_key: Int?
    var league_logo: String?
    var country_logo: String?
}

class EventsResult: Decodable {
    let success: Int?
    var result: [Event]?
}

//MARK: Teams

class Teams: Decodable {
    var team_key: Int?
    var team_name: String?
    var team_logo: String?
    var players: [Player]?
}

class Player: Decodable{
    var player_name: String?
    var player_type: String?
    var player_number: String?
    var player_image: String?
}

class TeamsResult: Decodable {
    let success: Int?
    var result: [Teams]?
}


//MARK: Results

class Result: Decodable {
    var event_key: Int?
    var event_date: String?
    var event_date_stop: String?
    var event_time: String?
    var event_home_team: String?
    var event_away_team: String?
    var event_final_result: String?
    var event_home_final_result: String?
    var event_away_final_result: String?
    var country_name: String?
    var league_name: String?
    var league_key: Int?
    var league_round: String?
    var league_season: String?
    var event_live: String?
    var event_stadium: String?
    var event_referee: String?
    var home_team_logo: String?
    var event_home_team_logo: String?
    var away_team_logo: String?
    var event_away_team_logo: String?
    var event_country_key: Int?
    var league_logo: String?
    var country_logo: String?
}

class ResultsResult: Decodable {
    let success: Int?
    var result: [Result]?
}
