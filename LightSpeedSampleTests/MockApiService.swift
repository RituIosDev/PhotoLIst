//
//  MockApiService.swift
//  LightSpeedSampleTests
//
//  Created by Ritu on 2022-12-10.
//

import XCTest
@testable import LightSpeedSample

class MockApiService: APIServiceProtocol {
    
    var isFetchPopularPhotoCalled = false
    var completePhotos: [Photos] = [Photos]()
    var completeClosure: (([Photos], Error?) -> ())!


    func fetchPhotos(completion: @escaping ([Photos], Error?) -> Void) {
        isFetchPopularPhotoCalled = true
        completeClosure = completion
    }
        
    func fetchSuccess() {
        completeClosure( completePhotos, nil )
    }
    
    func fetchFail(error: Error?) {
        completePhotos = [Photos]()
        completeClosure( completePhotos, error )
    }

}
