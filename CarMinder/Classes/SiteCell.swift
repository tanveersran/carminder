//
//  SiteCell.swift
//  CarMinder
//
//  Created by Birarpanjot Singh on 3/30/24.
//  This file is used to create object for SiteCell class, it is used to show the table which has title
//  , subtitle and image.
//

import UIKit

class SiteCell: UITableViewCell {

    let primaryLabel = UILabel() // label that provides title information
    let secondaryLabel = UILabel() // label that provides subtitle information
    let myImageView = UIImageView() // image view to show image
    
    // init function is used to initialize the class of SiteCell
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        // setting properties of primaryLabel
        primaryLabel.textAlignment = NSTextAlignment.left
        primaryLabel.font = UIFont.boldSystemFont(ofSize: 24)
        primaryLabel.backgroundColor = UIColor.clear
        primaryLabel.textColor = UIColor.white
        
        // setting properties of secondaryLabel
       secondaryLabel.textAlignment = NSTextAlignment.left
        secondaryLabel.font = UIFont.boldSystemFont(ofSize: 13)
        secondaryLabel.backgroundColor = UIColor.clear
        secondaryLabel.textColor = UIColor.white
        
        // calling super class init method
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(primaryLabel)
        contentView.addSubview(secondaryLabel)
        contentView.addSubview(myImageView)
        
        
    }
    
    // init? function is called in case of error in init function
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // layoutSubviews function is used to set the frame of labels
    override func layoutSubviews() {
        
        // setting frame of primaryLabel
        var f = CGRect(x: 100, y: 5, width: 460, height: 30)
        primaryLabel.frame = f
        
        // setting frame of secondaryLabel
        f = CGRect(x: 100, y: 40, width: 460, height: 20)
        secondaryLabel.frame = f
        
        // setting frame of myImageView
        f = CGRect(x: 5, y: 5, width: 70, height: 55)
        myImageView.frame = f
    }

// setSelected function is used to set the selected state of the cell
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
