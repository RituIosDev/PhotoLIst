//
//  ListViewModel.swift
//  LightSpeedSample
//
//  Created by Ritu on 2022-12-08.
//

import Foundation
import UIKit
import CoreData

class ListViewModel: NSObject {
    
    //MARK: - Variables
    private var arrPhotos: [Photos] = [Photos]()
    
    private let apiService: APIServiceProtocol
    init( apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }

    private lazy var coreDataStack = CoreDataStack()
    private lazy var reportService = PhotoListService(
      managedObjectContext: coreDataStack.mainContext,
      coreDataStack: coreDataStack
    )
    
    var reloadTableView: (() -> Void)?
    private var cellViewModel: [ListViewCellModel] = [ListViewCellModel]() {
        didSet {
            self.reloadTableView?()
        }
    }

    var numberOfCells: Int {
        return cellViewModel.count
    }

    
    //MARK: - Save and Fetch data
    func getDataFromServer(){
        let status = Reach().connectionStatus()
        switch status {
        case .unknown, .offline:
            // Show alert if internet not available.
            CommonFunctions.sharedCommonFunctions.alert(title: NSLocalizedString(internetNotAvailableTitle, comment: ""), message: NSLocalizedString(internetNotAvailableMsg, comment: ""))
        default:
            //Loader to update user to wait for call result
            CommonFunctions.sharedCommonFunctions.show_LoadingIndicator(strLoadingText: loaderWaiting)
            apiService.fetchPhotos { [weak self] photos, error in
                //Update UI as per response
                DispatchQueue.main.async {
                    CommonFunctions.sharedCommonFunctions.hide_LoadingIndicatorOnView()
                    if error == nil{
                        self?.arrPhotos = photos
                    }else{
                        CommonFunctions.sharedCommonFunctions.alert(title: tryAgain, message: noServerRecord)
                    }
                }
            }
        }
    }
    
    func getDataFromLocal(){
        if let data = reportService.getPhotos(){
            if !data.isEmpty{
                var cellModelObj = [ListViewCellModel]()
                for item in data{
                    let photoObj = Photos(id: item.id, author: item.author, url: item.url, download_url: item.download_url, imageData: item.imageData)
                    cellModelObj.append(createCellModel(photo: photoObj))
                }
                cellViewModel = cellModelObj
            }
        }
    }
    

    func addDataToLocal(photoObj: Photos){
        var randomElement = photoObj
        CommonFunctions.sharedCommonFunctions.show_LoadingIndicator(strLoadingText: loaderWaiting)
        if let fileURL = URL(string: randomElement.download_url ?? placeHolderImageUrl){
            do{
                let fileData = try Data (contentsOf: fileURL)
                let imageString = fileData.base64EncodedString ()
                let imageData = Data (base64Encoded: imageString)!
                randomElement.imageData = imageData

            }catch{
                CommonFunctions.sharedCommonFunctions.hide_LoadingIndicatorOnView()
                CommonFunctions.sharedCommonFunctions.alert(title: tryAgain, message: error.localizedDescription)
                return
            }
        }
        
        reportService.add(randomElement) { status, error in
            if error == nil{
                let cellModelObj = ListViewCellModel(lblAuthor: randomElement.author ?? "", imgDisplay: randomElement.imageData ?? Data(),photoId: randomElement.id ?? "")
                self.cellViewModel.append(cellModelObj)
            }else{
                CommonFunctions.sharedCommonFunctions.hide_LoadingIndicatorOnView()
                CommonFunctions.sharedCommonFunctions.alert(title: tryAgain, message: saveIssue)
            }
        }
    }

    
    
    //MARK: - Custom Functions
    func getLastIndex() -> Int{
        return cellViewModel.count-1
    }

    //MARK: - Set Cell Data
    func createCellModel(photo: Photos) -> ListViewCellModel {
        var author = ""
        var imageData = Data()
        var photoId = ""
        if let value = photo.author{
            author = value
        }
        if let value = photo.imageData{
            imageData = value
        }
        if let value = photo.id{
            photoId = value
        }

        return ListViewCellModel(lblAuthor: author, imgDisplay: imageData,photoId: photoId)
    }

    func getCellViewModel(at indexPath: IndexPath) -> ListViewCellModel {
        return cellViewModel[indexPath.row]
    }
    
    func addAndFetchFromLocal(){
        if let randomElement = arrPhotos.randomElement()  {
            addDataToLocal(photoObj: randomElement)
        }else{
            CommonFunctions.sharedCommonFunctions.alert(title: warn, message: noDataForSave)
        }
    }

}

