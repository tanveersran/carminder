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

// init function is used to initialize the class of DocumentCell
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        // setting properties of primaryLabel
        primaryLabel.textAlignment = NSTextAlignment.left
        primaryLabel.font = UIFont.boldSystemFont(ofSize: 17)
        primaryLabel.backgroundColor = UIColor.clear
        primaryLabel.textColor = UIColor.black
        
        // setting properties of secondaryLabel
       secondaryLabel.textAlignment = NSTextAlignment.left
        secondaryLabel.font = UIFont.boldSystemFont(ofSize: 13)
        secondaryLabel.backgroundColor = UIColor.clear
        secondaryLabel.textColor = UIColor.blue
        
        // setting properties of thirdLabel
       thirdLabel.textAlignment = NSTextAlignment.left
        thirdLabel.font = UIFont.boldSystemFont(ofSize: 13)
        thirdLabel.backgroundColor = UIColor.clear
        thirdLabel.textColor = UIColor.red
        
        // calling super class init method
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(primaryLabel)
        contentView.addSubview(secondaryLabel)
        contentView.addSubview(thirdLabel)
        
        
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
        var f = CGRect(x: 5, y: 5, width: 460, height: 30)
        primaryLabel.frame = f
        
        // setting frame of secondaryLabel
        f = CGRect(x: 5, y: 40, width: 460, height: 20)
        secondaryLabel.frame = f
        
        // setting frame of thirdLabel
        f = CGRect(x: 55, y: 40, width: 460, height: 20)
        thirdLabel.frame = f
        
    }

//setSelected function is used to set the selected state of cell
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
