# Assignment
 It perform Api Call and Programatically design 


First need to correct Service URL in CountryTest.swift file
// correct URL:https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json
//This this for Unit test


Install pod 

pod 'Moya', '~> 13.0'
pod 'Kingfisher', '~> 5.0'
pod 'NVActivityIndicatorView'
pod 'ObjectMapper'


Build-in UI components

InfoTableViewCell and UnderlineFocusView are build-in UI components.

Assignment in this repository helps you to understand usege.

Creating your custom UI components programatically 

 You can create and register them like UITableViewCell.


Read this section or some sample code.

//
//  InfoTableViewCell.swift
//  Assessment
//
//  Created by Anil on 04/01/20.
//  Copyright © 2020 Anil. All rights reserved.
//

import UIKit
import Kingfisher

class InfoTableViewCell: UITableViewCell {
    
     var contact:ListData? {
            didSet {
                guard let contactItem = contact else {return}
                if let name = contactItem.title {
                    let imageURL = URL(string: contactItem.imageHref as String? ?? "")
                    profileImageView.kf.indicatorType = .activity
                    profileImageView.kf.setImage(with: imageURL)
                    nameLabel.text = name as String
                }
                if let detailinfo = contactItem.description {
                    jobTitleDetailedLabel.text = " \(detailinfo) "
                }
            }
        }
    
    
    //Unit test
    func ValidateTitleFields(listData: ListData) -> Bool {
        return listData.title?.length ?? 0 > 1
       }
       
       func ValidatedescriptionFields(listData: ListData) -> Bool {
            return listData.description?.length ?? 0 > 1
    }
       
       func ValidateimageHref(listData: ListData) -> Bool {
            return listData.imageHref?.length ?? 0 > 1
        }
    
    
    
    
    
    
    let profileImageView:UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit // image will naver be strecthed vertially or horizontally
        img.translatesAutoresizingMaskIntoConstraints = false // enable autolayout
        img.layer.cornerRadius = 35
        img.clipsToBounds = true
        return img
    }()
    
    
    let nameLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let jobTitleDetailedLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor =  .black
        label.clipsToBounds = true
        label.numberOfLines = 0
        label.preferredMaxLayoutWidth = 700
        label.lineBreakMode = NSLineBreakMode.byWordWrapping

        label.sizeToFit()

        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(profileImageView)
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(jobTitleDetailedLabel)
        
        
        profileImageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        profileImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 70).isActive = true
        
        
        nameLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: self.profileImageView.trailingAnchor, constant: 10).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        
        jobTitleDetailedLabel.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor, constant: 10).isActive = true
        jobTitleDetailedLabel.leadingAnchor.constraint(equalTo: self.profileImageView.trailingAnchor, constant: 10).isActive = true

        jobTitleDetailedLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor,constant: -10).isActive = true
        
        jobTitleDetailedLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
    
}


You can disable the pan gesture as follows.

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var refreshControl = UIRefreshControl()
    var navigationtitle:NSString?
    let feedsProvider = MoyaProvider<ReceipesServices>(plugins: [NetworkLoggerPlugin(verbose: true)])

    let detaillistTableview = UITableView()
    var listdata: [ListData] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //APi Call
        self.load()
        
        self.view.backgroundColor = .yellow
        
        view.addSubview(detaillistTableview)
        
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
        
        //navigationItem.title = "About Canada"
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        detaillistTableview.addSubview(refreshControl)


        // Do any additional setup after loading the view.
    }
    

    @objc func refresh(sender:AnyObject) {
       // Code to refresh table view
        load()
        //detaillistTableview.reloadData()
        refreshControl.endRefreshing()
    }
    
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    private func setupNavBar() {
        self.navigationItem.title = navigationtitle as String?
    }
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





