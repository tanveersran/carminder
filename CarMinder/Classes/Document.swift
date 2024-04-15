    //
    //  Document.swift
    //  CarMinder
    //
    //  Created by Tanveer on 4/1/24.
    //  This file is used to create object for Document class, it is used to store documents in our project.
    //

    import UIKit

    class Document: NSObject {
        var id : Int? // document id is saved in id field
        var title : String? // document title is saved in title field
        var paperDate : Date? // paper date is saved in paperDate field
        var imagesUrl: [String]? //images of document is saved in imagesUrl field and it can have multiple images
        var carId: Int? // car id is saved in carId field which comes from Car class
        

        // initWithData method is used to initialize the class of Document which have 5 parameters id, title, paperDate, imagesUrl, carId
        func initWithData(theRow i:Int, theTitle n:String, thePaperDate v:Date, theImagesUrl iu: [String], theCarId ima:Int
                        )
        {
            // we are assigning the values of parameters to the fields of Document class
            id = i
            title = n
            paperDate = v
            imagesUrl = iu
            carId = ima
            
        }
    }
