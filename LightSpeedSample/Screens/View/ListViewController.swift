//
//  ListViewController.swift
//  LightSpeedSample
//
//  Created by Ritu on 2022-12-08.
//

import UIKit
import CoreData

class ListViewController: UIViewController  {

    //MARK: - Outlets
    @IBOutlet weak var tblVwObj: UITableView!

    //MARK: - Variables
    lazy var viewModel = {
        ListViewModel()
    }()

    //MARK: - ViewDid LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Initialize View Model
        initViewModel()
    }
        
    //MARK: - Initializing View with data
    func initViewModel() {
        //Load data from Server
        viewModel.getDataFromServer()

        //Get Local Data
        viewModel.getDataFromLocal()
        
        //Reload Table View
        viewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.tblVwObj.reloadData()
                self?.tblVwObj.scrollToRow(at: IndexPath(row: self?.viewModel.getLastIndex() ?? 0, section: 0) , at: .bottom, animated: true)
                CommonFunctions.sharedCommonFunctions.hide_LoadingIndicatorOnView()
            }
        }
    }

    //MARK: - Button Actions
    @IBAction func btnFetchSaveClicked(_ sender: Any) {
        viewModel.addAndFetchFromLocal()
    }
}


extension ListViewController: UITableViewDelegate, UITableViewDataSource{
    
    //MARK: - Table View Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Check for empty data to show error placeholder
        viewModel.numberOfCells == 0 ? tblVwObj.setEmptyMessage(noSavedRecord) : tblVwObj.restore()
        return viewModel.numberOfCells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListViewCell.identifier, for: indexPath) as? ListViewCell else { fatalError(noXib) }

        let cellVM = viewModel.getCellViewModel(at: indexPath)
        cell.cellViewModel = cellVM
        
        return cell
    }
}


//MARK: - Extensions
//TableView extension which can be used throughout the project to show error or message on empty data
extension UITableView {
    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont(name: fontOfEmptyError, size: 15)
        messageLabel.sizeToFit()

        self.backgroundView = messageLabel
        self.separatorStyle = .none
    }

    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}
