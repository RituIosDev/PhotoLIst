//
//  ListViewModelTests.swift
//  LightSpeedSampleTests
//
//  Created by Ritu on 2022-12-08.
//

import XCTest
import CoreData
@testable import LightSpeedSample

class ListViewModelTests: XCTestCase {

    var viewModel: ListViewModel!
    var mockAPIService: MockApiService!

    var photoService: PhotoListService!
    var coreDataStack: TestCoreDataStack!

    override func setUp() {
        super.setUp()
        mockAPIService = MockApiService()
        viewModel = ListViewModel(apiService: mockAPIService)
        
        coreDataStack = TestCoreDataStack()
        photoService = PhotoListService(managedObjectContext: coreDataStack.mainContext, coreDataStack: coreDataStack)
    }

    override func tearDown() {
        super.tearDown()

        viewModel = nil
        mockAPIService = nil
        photoService = nil
        coreDataStack = nil
    }


    func test_get_data_from_server() {
        // Given
        mockAPIService.completePhotos = [Photos]()

        // When
        viewModel.getDataFromServer()

        // Assert
        XCTAssertTrue(mockAPIService!.isFetchPopularPhotoCalled)
    }
    
    func test_fetch_photo_fail() {
        let error = NSError()
        viewModel.getDataFromServer()
        mockAPIService.fetchFail(error: error)
        XCTAssertEqual( "", "")
    }
    
    func test_add_data_local() {
        let randomElement = Photos(id: "First", author: "Neil", width: 100, height: 100, url: "www.google.com", download_url: "www.google.com", imageData: Data())
        let photoObj = photoService.add(randomElement) { status, error in
            XCTAssertTrue(status == true)
        }
        XCTAssertNotNil(photoObj, "Report should not be nil")
        XCTAssertTrue(photoObj.author == "Neil")
        XCTAssertTrue(photoObj.width == 100)
        XCTAssertTrue(photoObj.height == 100)
        XCTAssertTrue(photoObj.url == "www.google.com")
        XCTAssertNotNil(photoObj.id, "First")
    }


    func testGetReports() {
        let randomElement = Photos(id: "First", author: "Neil", width: 100, height: 100, url: "www.google.com", download_url: "www.google.com", imageData: Data())

      let newPhoto = self.photoService.add(randomElement) { status, error in
      }

      let getPhotos = photoService.getPhotos()

      XCTAssertNotNil(getPhotos)
      XCTAssertTrue(getPhotos?.count == 1)
      XCTAssertTrue(newPhoto.id == getPhotos?.first?.id)
    }
    

}


