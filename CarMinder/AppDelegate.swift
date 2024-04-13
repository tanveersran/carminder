//
//  AppDelegate.swift
//  CarMinder
//
//  Created by Default User on 3/30/24.
//

import UIKit
import SQLite3

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var databaseName : String? = "carminder.db"
    var databasePath : String?
    var cars : [Car] = []
    var documents:[Document] = []
    var currentCarId: Int!
    var expenses : [Expense] = []
    var selectedImagePaths: [String] = []


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // this method creates an array of directories under ~/Documents
        let documentPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
       
        // ~/Documents is always at index 0
        let documentsDir = documentPaths[0]
        
        // append filename such that path is ~/Documents/MyDatabase.db
        databasePath = documentsDir.appending("/" + databaseName!)
        
        checkAndCreateDatabase()
//        readDataFromDatabase()
        
        return true
    }
    
    func checkAndCreateDatabase()
    {

        var success = false
        let fileManager = FileManager.default
        
        success = fileManager.fileExists(atPath: databasePath!)
    
        if success
        {
            return
        }

        let databasePathFromApp = Bundle.main.resourcePath?.appending("/" + databaseName!)
        
    
        try? fileManager.copyItem(atPath: databasePathFromApp!, toPath: databasePath!)

    return;
    }
    
    func readDataFromDatabase()
    {
  
    cars.removeAll()
    
        var db: OpaquePointer? = nil
        
        if sqlite3_open(self.databasePath, &db) == SQLITE_OK {
            print("Successfully opened connection to database at \(self.databasePath)")
            
            // step 7d - setup query - entries is the table name you created in step 0
            var queryStatement: OpaquePointer? = nil
            let queryStatementString : String = "select * from cars"
            
            // step 7e - setup object that will handle data transfer
            if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
                
                // step 7f - loop through row by row to extract dat
                while( sqlite3_step(queryStatement) == SQLITE_ROW ) {
                
                    // step 7g - extract columns data, convert from char* to NSString
                    // col 0 - id, col 1 = name, col 2 = email, col 3 = food
                    
                    let id: Int = Int(sqlite3_column_int(queryStatement, 0))
                    let cname = sqlite3_column_text(queryStatement, 1)
                    let cvin = sqlite3_column_text(queryStatement, 2)
                    let cimage = sqlite3_column_text(queryStatement, 3)
                    
                    
                    
                    let name = String(cString: cname!)
                    let vin = String(cString: cvin!)
                    let image = String(cString: cimage!)
                 
                    
                    
           
                    // step 7h - save to data object and add to array
                    let data : Car = Car.init()
                    data.initWithData(theRow: id,theName: name, theVin: vin,theImage : image)
                    cars.append(data)
                    
                    print("Query Result:")
                    print("\(id) | \(name) | \(vin) | \(image) ")
                    
                }
                // step 7i - clean up
                
                sqlite3_finalize(queryStatement)
            } else {
                print("SELECT statement could not be prepared")
            }
            
            
            // step 7j - close connection
            // move on to ViewController.swift
            sqlite3_close(db);

        } else {
            print("Unable to open database.")
        }
    
    }
    func readDataFromDatabaseDocumentsTable(id:Int)
    {
  
    documents.removeAll()
    
        var db: OpaquePointer? = nil
        
        if sqlite3_open(self.databasePath, &db) == SQLITE_OK {
            print("Successfully opened connection to database at \(self.databasePath)")
            
            var queryStatement: OpaquePointer? = nil
            let queryStatementString : String = "select * from documents where car_id = \(currentCarId!)"
            
            if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
                
                while( sqlite3_step(queryStatement) == SQLITE_ROW ) {
                
                    
                    let id: Int = Int(sqlite3_column_int(queryStatement, 0))
                    let ctitle = sqlite3_column_text(queryStatement, 1)
                    let cdate = sqlite3_column_text(queryStatement, 2)
                    let cimagesUrl = sqlite3_column_text(queryStatement, 3)
                    let ccarId = sqlite3_column_int(queryStatement, 4)
                    
                    
                    
                    let title = String(cString: ctitle!)
                    let dateString = String(cString: cdate!)
                    let imagesUrlArray = String(cString: cimagesUrl!).components(separatedBy: ",")
                    
                    
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd"
                    
                    guard let date = dateFormatter.date(from:dateString) else{
                        fatalError("Faild to convert date string to date object")
                    }
                    print ("car id = \(ccarId)")
                    let data : Document = Document.init()
                    data.initWithData(theRow: id,theTitle: title, thePaperDate: date, theImagesUrl: imagesUrlArray,theCarId: Int(ccarId) )
                    documents.append(data)
                    
                    print("Query Result:")
                    print("\(id) | \(title) | \(date) | \(imagesUrlArray) | \(ccarId) ")
                    
                }
                
                sqlite3_finalize(queryStatement)
            } else {
                print("SELECT statement could not be prepared")
            }
            
          
            sqlite3_close(db);

        } else {
            print("Unable to open database.")
        }
    
    }
    
    func readDataFromDatabaseExpenseTable(id:Int)
    {
  
    expenses.removeAll()
    
        var db: OpaquePointer? = nil
        
        if sqlite3_open(self.databasePath, &db) == SQLITE_OK {
            print("Successfully opened connection to database at \(self.databasePath)")
            
            var queryStatement: OpaquePointer? = nil
            let queryStatementString : String = "select * from expenses where car_id = \(currentCarId!)"
            
            if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
                
                while( sqlite3_step(queryStatement) == SQLITE_ROW ) {
                
                    
                    let id: Int = Int(sqlite3_column_int(queryStatement, 0))
                    let ctitle = sqlite3_column_text(queryStatement, 1)
                    let ccost = sqlite3_column_int(queryStatement, 2)
                    let cimagesUrl = sqlite3_column_text(queryStatement, 3)
                    let ccarId = sqlite3_column_int(queryStatement, 4)
                    
                    
                    
                    let title = String(cString: ctitle!)
                    // convert back to arrayß
                    let imagesUrlArray = String(cString: cimagesUrl!).components(separatedBy: ",")
                    
                    
                    let data : Expense = Expense.init()
                    data.initWithData(theRow: id,theTitle: title,theCost:  Int(ccost), theImagesUrl: imagesUrlArray ,theCarId: Int(ccarId) )
                    expenses.append(data)
                    
                    print("Query Result:")
                    print("\(id) | \(title) | \(ccost) | \(imagesUrlArray) | \(ccarId) ")
                    
                }
                
                sqlite3_finalize(queryStatement)
            } else {
                print("SELECT statement could not be prepared")
            }
            
          
            sqlite3_close(db);

        } else {
            print("Unable to open database.")
        }
    
    }
    
   
    func insertIntoDatabase(car : Car) -> Bool
    {
        // step 16b - define sqlite3 object to interact with db
        var db: OpaquePointer? = nil
        var returnCode : Bool = true
        
        // step 16c - open connection to db file - this is C code
        if sqlite3_open(self.databasePath, &db) == SQLITE_OK {
            print("Successfully opened connection to database at \(String(describing: self.databasePath))")
            
            // step 16d - setup query - entries is the table name you created in step 0
            var insertStatement: OpaquePointer? = nil
            let insertStatementString : String = "insert into cars values(NULL, ?, ?,?)"
            
            // step 16e - setup object that will handle data transfer
            if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
               
           
                let nameStr = car.name! as NSString
                let vinStr = car.vin! as NSString
                let imageStr = car.image! as NSString
               

                sqlite3_bind_text(insertStatement, 1, nameStr.utf8String, -1, nil)
                sqlite3_bind_text(insertStatement, 2, vinStr.utf8String, -1, nil)
                sqlite3_bind_text(insertStatement, 3, imageStr.utf8String, -1, nil)
               
             
                if sqlite3_step(insertStatement) == SQLITE_DONE {
                    let rowID = sqlite3_last_insert_rowid(db)
                    print("Successfully inserted row. \(rowID)")
                } else {
                    print("Could not insert row.")
                    returnCode = false
                }
               
                sqlite3_finalize(insertStatement)
            } else {
                print("INSERT statement could not be prepared.")
                returnCode = false
            }
            
            
            sqlite3_close(db);
            
        } else {
            print("Unable to open database.")
            returnCode = false
        }
        return returnCode
    }
    func insertIntoDocumentsTable(document : Document) -> Bool
    {
        // step 16b - define sqlite3 object to interact with db
        var db: OpaquePointer? = nil
        var returnCode : Bool = true
        
        // step 16c - open connection to db file - this is C code
        if sqlite3_open(self.databasePath, &db) == SQLITE_OK {
            print("Successfully opened connection to database at \(String(describing: self.databasePath))")
            
            // step 16d - setup query - entries is the table name you created in step 0
            var insertStatement: OpaquePointer? = nil
            let insertStatementString : String = "insert into documents values(NULL, ?, ?,?,?)"
            
            // step 16e - setup object that will handle data transfer
            if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
               
           
                let title = document.title! as NSString
                let paperDate = document.paperDate! as NSDate
                // get the array and join it to a string to be stored into db
                let imagesUrl = document.imagesUrl!.joined(separator: ",") as NSString
                let car_id = document.carId! as NSInteger
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                
                let dateString = dateFormatter.string(from: paperDate as Date)
               

                sqlite3_bind_text(insertStatement, 1, title.utf8String, -1, nil)
                sqlite3_bind_text(insertStatement, 2, (dateString as NSString).utf8String, -1, nil)
                sqlite3_bind_text(insertStatement, 3, imagesUrl.utf8String, -1, nil)
                sqlite3_bind_int(insertStatement, 4, Int32(Int(car_id)))
               
             
                if sqlite3_step(insertStatement) == SQLITE_DONE {
                    let rowID = sqlite3_last_insert_rowid(db)
                    print("Successfully inserted row. \(rowID)")
                } else {
                    print("Could not insert row.")
                    returnCode = false
                }
               
                sqlite3_finalize(insertStatement)
            } else {
                print("INSERT statement could not be prepared.")
                returnCode = false
            }
            
            
            sqlite3_close(db);
            
        } else {
            print("Unable to open database.")
            returnCode = false
        }
        return returnCode
    }
    func insertIntoExpensesTable(expense : Expense) -> Bool
    {
        // step 16b - define sqlite3 object to interact with db
        var db: OpaquePointer? = nil
        var returnCode : Bool = true
        
        // step 16c - open connection to db file - this is C code
        if sqlite3_open(self.databasePath, &db) == SQLITE_OK {
            print("Successfully opened connection to database at \(String(describing: self.databasePath))")
            
            // step 16d - setup query - entries is the table name you created in step 0
            var insertStatement: OpaquePointer? = nil
            let insertStatementString : String = "insert into expenses values(NULL, ?, ?,?,?)"
            
            // step 16e - setup object that will handle data transfer
            if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
               
           
                let title = expense.title! as NSString
                let cost = expense.cost! as NSInteger
                let imagesUrl = expense.imagesUrl!.joined(separator: ",") as NSString
                let car_id = expense.carId! as NSInteger
                
               
               

                sqlite3_bind_text(insertStatement, 1, title.utf8String, -1, nil)
                sqlite3_bind_int(insertStatement, 2, Int32(Int(cost)))
                sqlite3_bind_text(insertStatement, 3, imagesUrl.utf8String, -1, nil)
                sqlite3_bind_int(insertStatement, 4, Int32(Int(car_id)))
               
             
                if sqlite3_step(insertStatement) == SQLITE_DONE {
                    let rowID = sqlite3_last_insert_rowid(db)
                    print("Successfully inserted row. \(rowID)")
                } else {
                    print("Could not insert row.")
                    returnCode = false
                }
               
                sqlite3_finalize(insertStatement)
            } else {
                print("INSERT statement could not be prepared.")
                returnCode = false
            }
            
            
            sqlite3_close(db);
            
        } else {
            print("Unable to open database.")
            returnCode = false
        }
        return returnCode
    }
    
    
    
    func insertIntoTracker(id : Int) -> Bool
    {
        // step 16b - define sqlite3 object to interact with db
        var db: OpaquePointer? = nil
        var returnCode : Bool = true
        
        // step 16c - open connection to db file - this is C code
        if sqlite3_open(self.databasePath, &db) == SQLITE_OK {
            print("Successfully opened connection to database at \(String(describing: self.databasePath))")
            
            // step 16d - setup query - entries is the table name you created in step 0
            var insertStatement: OpaquePointer? = nil
            let insertStatementString : String = "insert into tracker values(?)"
            
            // step 16e - setup object that will handle data transfer
            if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
               
           
                let current_id = id
               

                sqlite3_bind_int(insertStatement, 1, Int32(current_id))
                
               
             
                if sqlite3_step(insertStatement) == SQLITE_DONE {
                    let rowID = sqlite3_last_insert_rowid(db)
                    print("Successfully inserted row. \(rowID)")
                } else {
                    print("Could not insert row.")
                    returnCode = false
                }
               
                sqlite3_finalize(insertStatement)
            } else {
                print("INSERT statement could not be prepared.")
                returnCode = false
            }
            
            
            sqlite3_close(db);
            
        } else {
            print("Unable to open database.")
            returnCode = false
        }
        return returnCode
    }
    func deleteAllFromTracker() -> Bool {
        var db: OpaquePointer? = nil
        var returnCode: Bool = true

        // Open connection to db file
        if sqlite3_open(self.databasePath, &db) == SQLITE_OK {
            print("Successfully opened connection to database at \(String(describing: self.databasePath))")
            
            // Setup query to delete all rows from the tracker table
            var deleteStatement: OpaquePointer? = nil
            let deleteStatementString: String = "DELETE FROM tracker"
            
            // Prepare delete statement
            if sqlite3_prepare_v2(db, deleteStatementString, -1, &deleteStatement, nil) == SQLITE_OK {
                // Execute delete statement
                if sqlite3_step(deleteStatement) == SQLITE_DONE {
                    print("Successfully deleted all rows from the tracker table.")
                } else {
                    print("Could not delete rows from the tracker table.")
                    returnCode = false
                }
                sqlite3_finalize(deleteStatement)
            } else {
                print("DELETE statement could not be prepared.")
                returnCode = false
            }
            
            sqlite3_close(db);
            
        } else {
            print("Unable to open database.")
            returnCode = false
        }

        return returnCode

       }
    
    
 
    

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

