//
//  InfoTableViewCell.swift
//  Assessment
//
//  Created by Anil on 05/01/20.
//  Copyright © 2020 Anil. All rights reserved.
//

import UIKit
import Kingfisher

class InfoTableViewCell: UITableViewCell {
    
     var contact:ListData? {
            didSet {
                guard let contactItem = contact else {return}
                if let name = contactItem.title {
                    nameLabel.text = name as String
                }else{
                    nameLabel.text = " Title "
                }
                
                let pimage = UIImage(named: "no-photo")
                if let image = contactItem.imageHref {
                    let imageURL = URL(string: image as String)
                    profileImageView.kf.indicatorType = .activity
                    profileImageView.kf.setImage(with: imageURL, placeholder: pimage)
                }
                if let detailinfo = contactItem.description {
                    jobTitleDetailedLabel.text = " \(detailinfo) "
                }else{
                    jobTitleDetailedLabel.text = " No Data "
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
        label.numberOfLines = 0
        label.font = UIFont(name: "Avenir-Book", size: 12)
        label.textColor = UIColor.black
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
        
        let marginGuide = contentView.layoutMarginsGuide

        
        self.contentView.addSubview(profileImageView)
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(jobTitleDetailedLabel)
        
        
        profileImageView.centerYAnchor.constraint(equalTo: marginGuide.centerYAnchor).isActive = true
        profileImageView.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor, constant: 10).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 70).isActive = true
        
        
        nameLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor, constant: 10).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: self.profileImageView.trailingAnchor, constant: 10).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor, constant: -10).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        
        
        // configure authorLabel
        jobTitleDetailedLabel.translatesAutoresizingMaskIntoConstraints = false
        jobTitleDetailedLabel.leadingAnchor.constraint(equalTo: self.profileImageView.trailingAnchor, constant: 10).isActive = true
        jobTitleDetailedLabel.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
        jobTitleDetailedLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        jobTitleDetailedLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true

    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
    
    
    
}
