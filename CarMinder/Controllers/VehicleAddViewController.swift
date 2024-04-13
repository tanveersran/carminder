//
//  VehicleAddViewController.swift
//  CarMinder
//
//  Created by Default User on 3/30/24.
//

import UIKit

class VehicleAddViewController: UIViewController , UITextFieldDelegate{
    
    @IBOutlet var tfName : UITextField!
    @IBOutlet var tfVin : UITextField!
    let mainDelegate = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("vehicle add view controller")
        self.navigationController?.navigationBar.backItem?.rightBarButtonItem?.title = "back"
       
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func submitButtonClicked(_ sender: UIButton){

        let car : Car = Car.init()

        car.initWithData(theRow: 0, theName: tfName.text!,theVin: tfVin.text!, theImage:  "accord.jpeg" )


        // step 18c - do the insert into db
        let returnCode : Bool = mainDelegate.insertIntoDatabase(car: car)

        // step 18d - show alert box to indicate success/fail
        var returnMSG : String = "Car Added"

        if returnCode == false
        {
            returnMSG = "Car Add Failed"
        }

        let alertController = UIAlertController(title: "SQLite Add", message: returnMSG, preferredStyle: .alert)

        let cancelAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)

        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
    

   

}
