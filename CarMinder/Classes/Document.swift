//
//  Document.swift
//  CarMinder
//
//  Created by Default User on 4/1/24.
//

import UIKit

class Document: NSObject {
    var id : Int?
    var title : String?
    var paperDate : Date?
    var imagesUrl: [String]?
    var carId: Int?
    
    func initWithData(theRow i:Int, theTitle n:String, thePaperDate v:Date, theImagesUrl iu: [String], theCarId ima:Int
                      )
    {
        id = i
        title = n
        paperDate = v
        imagesUrl = iu
        carId = ima
        
    }
}
