//
//  MockLeaguesTest.swift
//  Sports-AppTests
//
//  Created by Moaz Khaled on 26/05/2023.
//

import XCTest
@testable import Sports_App

final class MockNetworkServicesTest: XCTestCase {
    
    var network: NetworkServiceProtocol?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        network = FakeNetworkService(shouldReturnError: true)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        network = nil
    }


    func tesFetchData(){
        
        network?.fetchData(url:"") { (root:LeagueResult?, error) in

            if let error = error {
                XCTFail()
            }else{
                guard let root = root else {
                    XCTAssertNil(root)
                    return
                }
                XCTAssertNotNil(root , "API Error")
            }
            
        }
    }
    
}
