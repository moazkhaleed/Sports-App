//
//  URLGeneratorTest.swift
//  Sports-AppTests
//
//  Created by Moaz Khaled on 30/05/2023.
//

import XCTest
@testable import Sports_App

final class URLGeneratorTest: XCTestCase {


    var urlGenerator : URLGenerator!
    override func setUpWithError() throws {
        urlGenerator = URLGenerator()
    }

    override func tearDownWithError() throws {
        urlGenerator = nil
    }
    
    func testCreateLatestResultsURL() {
        let leagueId = 123
        let actualURL = urlGenerator
            .appendBaseURL(base: URLGenerator.BASE_URL)
            .appendSportType(sportType: .football)
            .appendAPIKey(APIkey: URLGenerator.API_KEY)
            .appendMethodType(methodType: MethodType.Fixtures)
            .appendLeagueID(id: leagueId)
            .appendDateFromTo(isOld: false)
            .toURL()
        
        
        XCTAssertNotNil(actualURL)
    }
    
    func testGenerateLeaguesURL() {
        
        let expectedURL = "https://apiv2.allsportsapi.com/football?APIkey=\(URLGenerator.API_KEY)&met=Leagues"
        
        
        
        let actualURL = urlGenerator
            .appendBaseURL(base: URLGenerator.BASE_URL)
            .appendSportType(sportType: .football)
            .appendAPIKey(APIkey: URLGenerator.API_KEY)
            .appendMethodType(methodType: MethodType.Leagues)
            .toString()
        
        XCTAssertEqual(actualURL, expectedURL)
    }
    
    func testCreateUpcomingEventsURL() {
        
        let currentDate = Date()
        let targetDate = Calendar.current.date(byAdding: .year, value: 1, to: currentDate)!
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let leagueId = 100
        
        let expectedURL = "https://apiv2.allsportsapi.com/football?APIkey=\(URLGenerator.API_KEY)&met=Fixtures&leagueId=\(leagueId)&from=\(dateFormatter.string(from: currentDate))&to=\(dateFormatter.string(from: targetDate))"
        
       
        
        let actualURL = urlGenerator
            .appendBaseURL(base: URLGenerator.BASE_URL)
            .appendSportType(sportType: .football)
            .appendAPIKey(APIkey: URLGenerator.API_KEY)
            .appendMethodType(methodType: MethodType.Fixtures)
            .appendLeagueID(id: leagueId)
            .appendDateFromTo(isOld: false)
            .toString()
        
        XCTAssertTrue(actualURL == expectedURL)
    }
        
    func testCreateOneTeamURL() {
        let id = 456
        
        let expectedURL = "https://apiv2.allsportsapi.com/football/?APIkey=\(URLGenerator.API_KEY)&met=Teams&teamId=\(id)"
        
        let actualURL = urlGenerator
            .appendBaseURL(base: URLGenerator.BASE_URL)
            .appendSportType(sportType: .basketball)
            .appendAPIKey(APIkey: URLGenerator.API_KEY)
            .appendMethodType(methodType: MethodType.Teams)
            .appendTeamID(id: id)
            .toString()
        
        XCTAssertFalse(expectedURL == actualURL)
    }
    
    func testCreateTeamsURL() {
       
        let id = 123
        
        let expectedURL = "https://apiv2.allsportsapi.com/football?APIkey=\(URLGenerator.API_KEY)&met=Teams&leagueId=123"
        
        
        let actualURL = urlGenerator
            .appendBaseURL(base: URLGenerator.BASE_URL)
            .appendSportType(sportType: .football)
            .appendAPIKey(APIkey: URLGenerator.API_KEY)
            .appendMethodType(methodType: MethodType.Teams)
            .appendLeagueID(id: id)
            .toString()
        
        XCTAssertEqual(actualURL, expectedURL)
    }

}
