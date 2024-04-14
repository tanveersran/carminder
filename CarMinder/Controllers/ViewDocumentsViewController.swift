//
//  ViewDocumentsViewController.swift
//  CarMinder
//
//  Created by Default User on 4/1/24.
//

import UIKit

class ViewDocumentsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "View Documents"

    }
   
    
    @IBAction func viewDocumentButtonClicked()
    {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "VehicleDocumentViewController") as? VehicleDocumentViewController{
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func viewExpenseButtonClicked(){
        if let vc = storyboard?.instantiateViewController(withIdentifier: "VehicleExpensesViewController") as? VehicleExpensesViewController{
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    @IBAction func serviceReminderButtonClicked(){
        if let vc = storyboard?.instantiateViewController(withIdentifier: "ServiceReminderViewController") as? ServiceReminderViewController{
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    

  

}
