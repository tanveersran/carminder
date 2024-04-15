//
//  Expense.swift
//  CarMinder
//
//  Created by Birarpanjot Singh on 4/12/24.
// This file is used to create object for Expense class, it is used to store the expense details of car
//

import UIKit
import VisionKit

class Expense: NSObject {
    var id : Int? // id of the expense
    var title : String? // title of the expense
    var cost : Int? // cost of the expense
    var imagesUrl: [String]? // images url of the expense
    var carId: Int? // car id of the expense
    
    // init function is used to initialize the class of Expense
    func initWithData(theRow i:Int, theTitle n:String, theCost v:Int, theImagesUrl iu: [String], theCarId ima:Int
                      )
    {
        id = i // setting id of the expense
        title = n // setting title of the expense
        cost = v // setting cost of the expense
        imagesUrl = iu // setting images url of the expense
        carId = ima // setting car id of the expense
        
    }
}
