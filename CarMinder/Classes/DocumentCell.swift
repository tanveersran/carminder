//
//  DocumentCell.swift
//  CarMinder
//
//  Created by Rajat Rajat on 2024-04-01.
//

import UIKit

class DocumentCell: UITableViewCell {

    // step 11 - define 2 labels and an image view for our custom cell
    let primaryLabel = UILabel()
    let secondaryLabel = UILabel()
    let thirdLabel = UILabel()
    
    // step 11b - override the following constructor
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        // step 11c - configure primaryLabel
        primaryLabel.textAlignment = NSTextAlignment.left
        primaryLabel.font = UIFont.boldSystemFont(ofSize: 22)
        primaryLabel.backgroundColor = UIColor.clear
        primaryLabel.textColor = UIColor.black
        
        // step 11d - configure secondaryLabel
       secondaryLabel.textAlignment = NSTextAlignment.left
        secondaryLabel.font = UIFont.boldSystemFont(ofSize: 16)
        secondaryLabel.backgroundColor = UIColor.clear
        secondaryLabel.textColor = UIColor.black
        
        // step 11d - configure secondaryLabel
       thirdLabel.textAlignment = NSTextAlignment.left
        thirdLabel.font = UIFont.boldSystemFont(ofSize: 16)
        thirdLabel.backgroundColor = UIColor.clear
        thirdLabel.textColor = UIColor.black
        
        
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
