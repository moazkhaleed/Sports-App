//
//  NetworkServiceTests.swift
//  Sports-App
//
//  Created by Moaz Khaled on 30/05/2023.
//
import XCTest
@testable import Sports_App

final class NetworkServiceTests: XCTestCase {

    var networkService: NetworkServiceProtocol?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        networkService = NetworkService()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        networkService = nil
    }

    //MARK: League Details
    func testGetTeams() throws {
        let expectaion = expectation(description: "Waiting for the API to get Teams")
        let url = URLGenerator(sportType: .football,methodType: .Teams)
            .appendLeagueID(id: 3)
            .toString()
        
        networkService?.fetchData(url: url) { (root:TeamsResult?, err) in
            guard let teams = root?.result else
            {
                XCTFail("No Data")
                expectaion.fulfill()
                return
            }
            XCTAssertNotNil(teams)
            XCTAssertNotEqual(teams.count, 0, "API failed")
            expectaion.fulfill()
        }
        waitForExpectations(timeout: 3 , handler: nil)
    }
    
    func testGetResults() throws {
        let expectaion = expectation(description: "Waiting for the API to get Results")
        let url  = URLGenerator(sportType: .football,methodType: .Fixtures)
            .appendDateFromTo(isOld: true)
            .appendLeagueID(id: 3)
            .toString()
        networkService?.fetchData(url: url) { (root:ResultsResult?, err) in
            guard let results = root?.result else
            {
                XCTFail("No Data")
                expectaion.fulfill()
                return
            }
            XCTAssertNotNil(results)
            XCTAssertNotEqual(results.count, 0, "API failed")
            expectaion.fulfill()
        }
        waitForExpectations(timeout: 3 , handler: nil)
        
    }
    
    func testGetEvents() throws {
        let expectaion = expectation(description: "Waiting for the API to get Events")
        let url  = URLGenerator(sportType: .football,methodType: .Fixtures)
            .appendDateFromTo(isOld: false)
            .appendLeagueID(id: 200)
            .toString()
        
        networkService?.fetchData(url: url) { (root:EventsResult?, err) in
            guard let events = root?.result else
            {
                XCTFail("No Data")
                expectaion.fulfill()
                return
            }
            XCTAssertNotNil(events)
            XCTAssertNotEqual(events.count, 0, "API failed")
            expectaion.fulfill()
        }
        waitForExpectations(timeout: 3 , handler: nil)
    }
    
    func testGetLeagues() throws {
        let expectaion = expectation(description: "Waiting for the API to get Events")

        let url  = URLGenerator(sportType: .football,methodType: .Leagues).toString()

        networkService?.fetchData(url: url) { (root:LeagueResult?, err) in
            guard let leagues = root?.result else
            {
                XCTFail("No Data")
                expectaion.fulfill()
                return
            }
            XCTAssertNotNil(leagues)
            XCTAssertNotEqual(leagues.count, 0, "API failed")
            expectaion.fulfill()
        }
        waitForExpectations(timeout: 3 , handler: nil)
        
    }
}

