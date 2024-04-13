//
//  Expense.swift
//  CarMinder
//
//  Created by Default User on 4/12/24.
//

import UIKit
import VisionKit

class Expense: NSObject {
    var id : Int?
    var title : String?
    var cost : Int?
    var imagesUrl: [String]?
    var carId: Int?
    
    func initWithData(theRow i:Int, theTitle n:String, theCost v:Int, theImagesUrl iu: [String], theCarId ima:Int
                      )
    {
        id = i
        title = n
        cost = v
        imagesUrl = iu
        carId = ima
        
    }
}
