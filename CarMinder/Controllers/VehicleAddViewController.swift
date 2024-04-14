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
        
        if(mainDelegate.insertIntoDatabase(car: car)){
            if let vc = storyboard?.instantiateViewController(withIdentifier: "VehicleListViewController") as? VehicleListViewController{
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
        }
        
    }
    

   

}
