//
//  ListViewController.swift
//  Assessment
//
//  Created by Anil on 05/01/20.
//  Copyright © 2020 Anil. All rights reserved.
//

import UIKit
import SwiftUI
import Combine
import Moya
import ObjectMapper
import Foundation

/// Description
class ListViewController: UIViewController {
    
    var refreshControl = UIRefreshControl()
    var navigationtitle:NSString?
    let feedsProvider = MoyaProvider<ReceipesServices>(plugins: [NetworkLoggerPlugin(verbose: true)])

    let detaillistTableview = UITableView()
    var listdata: [ListData] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialLoad()
        
        
        //APi Call
        self.load()
        
    }
}

 
//MARK:- UITableView Methods
extension ListViewController: UITableViewDelegate, UITableViewDataSource{
    
    //MARK: UITableview
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           listdata.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "InfoDetailsCell", for: indexPath) as! InfoTableViewCell
           
           cell.contact = listdata[indexPath.row]
           return cell
       }
    
}
//MARK:- Custome Methods

extension ListViewController{
    
    func initialLoad() {
        
         self.view.backgroundColor = .yellow
               
        view.addSubview(detaillistTableview)
        
        configureTableView()
        
            //Pull To Refresh
               refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
               refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
               detaillistTableview.addSubview(refreshControl)

    }
    func configureTableView() {
        detaillistTableview.dataSource = self
        detaillistTableview.estimatedRowHeight = 100
        detaillistTableview.rowHeight = UITableView.automaticDimension
        detaillistTableview.register(InfoTableViewCell.self, forCellReuseIdentifier: "InfoDetailsCell")
        
        view.addSubview(detaillistTableview)
        detaillistTableview.translatesAutoresizingMaskIntoConstraints = false
        detaillistTableview.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        detaillistTableview.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        detaillistTableview.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        detaillistTableview.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }

    @objc func refresh(sender:AnyObject) {
       // Code to refresh table view
        load()
        refreshControl.endRefreshing()
    }
    
    private func setupNavBar() {
        self.navigationItem.title = navigationtitle as String?
    }
    
}

//MARK:- API Call

extension ListViewController{
    
    func load() {
        feedsProvider.request(.feeds) { result in
            switch result{
            case let .success(response):
                do{
                    let responseStrInISOLatin = String(data: response.data, encoding: String.Encoding.isoLatin1)

                    guard let modifiedDataInUTF8Format = responseStrInISOLatin?.data(using: String.Encoding.utf8) else {
                        // print("could not convert data to UTF-8 format")
                         return
                    }
                    let responseJSONDict = try JSONSerialization.jsonObject(with: modifiedDataInUTF8Format, options: .mutableContainers) as? [String:Any]
                                 //  print(responseJSONDict as Any)
                    let dataaaa = responseJSONDict?["rows"] as! NSArray
                    self.navigationtitle = responseJSONDict?["title"] as? String as NSString?
                    self.setupNavBar()
                    if let popular = Mapper<ListData>().mapArray(JSONObject:dataaaa) {
                        
                        if popular.count != 0 {
                            self.listdata = [ListData]()
                            self.listdata = popular
                           // print(self.listdata)
                            self.detaillistTableview.reloadData()
                        }
                    }
                }catch let error{
                    print(error)
                }
                break
            case .failure(_):
                //print(Strings.failure,error)
                break
            }
        }
    }
    
}



