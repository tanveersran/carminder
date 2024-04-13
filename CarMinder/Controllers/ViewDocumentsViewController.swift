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
     

        // Do any additional setup after loading the view.
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
    

  

}
