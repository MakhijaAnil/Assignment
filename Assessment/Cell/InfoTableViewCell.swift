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
