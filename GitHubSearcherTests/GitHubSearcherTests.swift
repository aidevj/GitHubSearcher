//
//  GitHubSearcherTests.swift
//  GitHubSearcher
//
//  Created by Aiden Melendez on 4/14/20.
//  Copyright © 2020. All rights reserved.
//

import XCTest
@testable import GitHubSearcher

class GitHubSearcherTests: XCTestCase {

    override func setUp() { }

    override func tearDown() { }

    func testCanDecodeUsersModel() {
        // Arrange
        let gitHubAPI = GitHubAPI(service: MockAPIService())
        let searchTerm = "Tom"

        // Act
        var users: [UserSearchResult]?
        let expectation = XCTestExpectation(description: "testCanDecodeUsersModel")
        gitHubAPI.search(user: searchTerm) { (result) in
            switch result {
            case .success(let result):
                users = result.users
            case .failure(let apiError):
                XCTFail(apiError.debugDescription)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 4.0)
        
        // Assert
        XCTAssertNotNil(users, "Error - nil returned for UserSearchResults")
        XCTAssertFalse(users?.isEmpty ?? false, "Error - users is empty")
    }
    
    func testCanDecodeRepoCount() {
        // Arrange
        let tomUrl = MockJSON.tomResults.rawValue
        let gitHubAPI = GitHubAPI(service: MockAPIService())
        
        // Act
        var user: User?
        let expectation = XCTestExpectation(description: "testCanDecodeUsersModel")
        gitHubAPI.userDetails(for: tomUrl) { result in
            switch result {
            case .success(let result):
                user = result
            case .failure(let apiError):
                XCTFail(apiError.debugDescription)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 4.0)
        
        // Assert
        XCTAssertNotNil(user, "Error - nil returned for User")
        XCTAssertGreaterThan(user?.reposCount ?? 0, 0, "Error - No repos found!")
    }

}
