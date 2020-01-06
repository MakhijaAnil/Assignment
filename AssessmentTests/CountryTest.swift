//
//  CountryTest.swift
//  AssessmentTests
//
//  Created by Anil on 05/01/20.
//  Copyright © 2020 Anil. All rights reserved.
//

import Foundation
import XCTest
import SwiftUI
import Combine
import Moya
import ObjectMapper

@testable import Assessment


class CountryTest: XCTestCase {
    
    let feedsProvider = MoyaProvider<ReceipesServices>(plugins: [NetworkLoggerPlugin(verbose: true)])

    var sut: URLSession!
     
     override func setUp() {
       super.setUp()
       sut = URLSession(configuration: .default)
     }
     
     override func tearDown() {
       sut = nil
       super.tearDown()
     }
    
    // Asynchronous test: success fast, failure slow
      func testValidCallToiTunesGetsHTTPStatusCode200() {
        // given URL worng
        //Please input this url and again run it
       // correct URL:https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json
        //URLPath.APIBaseURL
        let url = URL(string: "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/")
        // 1
        let promise = expectation(description: "Status code: 200")
        
        // when
        let dataTask = sut.dataTask(with: url!) { data, response, error in
          // then
          if let error = error {
            XCTFail("Error: \(error.localizedDescription)")
            return
          } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
            if statusCode == 200 {
              // 2
              promise.fulfill()
            } else {
              XCTFail("Status code: \(statusCode)")
            }
          }
        }
        dataTask.resume()
        // 3
        wait(for: [promise], timeout: 5)
      }
      
      // Asynchronous test: faster fail
      func testCallToiTunesCompletes() {
        // given
        let url = URL(string: URLPath.APIBaseURL)
        // 1
        let promise = expectation(description: "Completion handler invoked")
        var statusCode: Int?
        var responseError: Error?
        
        // when
        let dataTask = sut.dataTask(with: url!) { data, response, error in
          statusCode = (response as? HTTPURLResponse)?.statusCode
          responseError = error
          // 2
          promise.fulfill()
        }
        dataTask.resume()
        // 3
        wait(for: [promise], timeout: 5)
        
        // then
        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 200)
      }
    }


