//
//  DocumentCell.swift
//  CarMinder
//
//  Created by Rajat Rajat on 2024-04-01.
//  This file is used to create object for DocumentCell class, it is used to view document
//  and document cell class is required to show each document.
//

import UIKit

class DocumentCell: UITableViewCell {

    let primaryLabel = UILabel() // label to provide primary information
    let secondaryLabel = UILabel() // label to provide secondary information
    let thirdLabel = UILabel()  // label to provide additional information

// 
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        primaryLabel.textAlignment = NSTextAlignment.left
        primaryLabel.font = UIFont.boldSystemFont(ofSize: 17)
        primaryLabel.backgroundColor = UIColor.clear
        primaryLabel.textColor = UIColor.black
        
        // step 11d - configure secondaryLabel
       secondaryLabel.textAlignment = NSTextAlignment.left
        secondaryLabel.font = UIFont.boldSystemFont(ofSize: 13)
        secondaryLabel.backgroundColor = UIColor.clear
        secondaryLabel.textColor = UIColor.blue
        
        // step 11d - configure secondaryLabel
       thirdLabel.textAlignment = NSTextAlignment.left
        thirdLabel.font = UIFont.boldSystemFont(ofSize: 13)
        thirdLabel.backgroundColor = UIColor.clear
        thirdLabel.textColor = UIColor.red
        
        
        // step 11e - no configuring of myImageView needed, instead add all 3 items manually as below
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(primaryLabel)
        contentView.addSubview(secondaryLabel)
        contentView.addSubview(thirdLabel)
        
        
    }
    
    // step 11f - override base constructor to avoid compile error
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // step 11g - define size and location of all 3 items as below
    // return to ChooseSiteViewController.swift
    override func layoutSubviews() {
        
        var f = CGRect(x: 5, y: 5, width: 460, height: 30)
        primaryLabel.frame = f
        
        f = CGRect(x: 5, y: 40, width: 460, height: 20)
        secondaryLabel.frame = f
        
        f = CGRect(x: 55, y: 40, width: 460, height: 20)
        thirdLabel.frame = f
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
