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
          // let cell = tableView.dequeueReusableCell(withIdentifier: "InfoDetailsCell", for: indexPath)
           let cell = tableView.dequeueReusableCell(withIdentifier: "InfoDetailsCell", for: indexPath) as! InfoTableViewCell

           
           cell.contact = listdata[indexPath.row]
         //  cell.detailTextLabel?.text = "Helloalslksdfsdfskldflsdflflsdlfdxcvxcksdlfslf;k;sd;kldfgdnfgldl"

           //cell.imageView?.image = UIImage(named: "hello")

           return cell
       }
       // UITableViewAutomaticDimension calculates height of label contents/text
       func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           // Swift 4.2 onwards
           return UITableView.automaticDimension
       }
    
}
//MARK:- Custome Methods

extension ListViewController{
    
    func initialLoad() {
        
         self.view.backgroundColor = .yellow
               
        view.addSubview(detaillistTableview)
        
        configureTableView()
        
        
               //navigationItem.title = "About Canada"
               //Pull To Refresh
               refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
               refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
               detaillistTableview.addSubview(refreshControl)

    }
    
    func configureTableView() {
        //Constain for Tableview
        detaillistTableview.translatesAutoresizingMaskIntoConstraints = false
        
        detaillistTableview.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        detaillistTableview.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        detaillistTableview.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        detaillistTableview.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        detaillistTableview.delegate = self
        detaillistTableview.dataSource = self
        
           detaillistTableview.rowHeight = UITableView.automaticDimension
           detaillistTableview.estimatedRowHeight = UITableView.automaticDimension

        
        detaillistTableview.register(InfoTableViewCell.self, forCellReuseIdentifier: "InfoDetailsCell")
        
    }
    @objc func refresh(sender:AnyObject) {
       // Code to refresh table view
        load()
        //detaillistTableview.reloadData()
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
                         print("could not convert data to UTF-8 format")
                         return
                    }
                    let responseJSONDict = try JSONSerialization.jsonObject(with: modifiedDataInUTF8Format, options: .mutableContainers) as? [String:Any]
                                   print(responseJSONDict as Any)
                    let dataaaa = responseJSONDict?["rows"] as! NSArray
                    self.navigationtitle = responseJSONDict?["title"] as? String as NSString?
                    self.setupNavBar()
                    if let popular = Mapper<ListData>().mapArray(JSONObject:dataaaa) {
                        
                        if popular.count != 0 {
                            self.listdata = [ListData]()
                            self.listdata = popular
                            print(self.listdata)
                            self.detaillistTableview.reloadData()
                        }
                    }
                }catch let error{
                    print(error)
                }
                break
            case let .failure(error):
                //print(Strings.failure,error)
                break
            }
        }
    }
    
}



