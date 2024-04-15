//
//  ViewDocumentsViewController.swift
//  CarMinder
//
//  Created by Rajat
//  This controller is the home of all the options you can select like expenses, documents
//

import UIKit

class ViewDocumentsViewController: UIViewController {
    
    // using the app delegate
    let mainDelegate = UIApplication.shared.delegate as! AppDelegate
    @IBOutlet var viewDocumentButton: UIButton! // this is to connect with the view document button
    @IBOutlet var viewExpenseButton: UIButton! // this is to connect with the expense button
    @IBOutlet var serviceReminderButton: UIButton! // this is to connect with the services button
    @IBOutlet var viewMapButton: UIButton! // this is to connect with the view map button

    // setting up button animations and the selected cars name on the view
    override func viewDidLoad() {
        super.viewDidLoad()
        if let car = mainDelegate.cars.first(where: { $0.id == mainDelegate.currentCarId}) {
            title = car.name
        }
        
            viewDocumentButton.alpha = 0
            viewExpenseButton.alpha = 0
            serviceReminderButton.alpha = 0
            viewMapButton.alpha = 0
            
        UIView.animate(withDuration: 0.2, delay: 0, options: [], animations: {
                self.viewDocumentButton.alpha = 1
            }, completion: { _ in
                UIView.animate(withDuration: 0.1, delay: 0, options: [], animations: {
                    self.viewExpenseButton.alpha = 1
                }, completion: { _ in
                    UIView.animate(withDuration: 0.1, delay: 0, options: [], animations: {
                        self.serviceReminderButton.alpha = 1
                    }, completion: { _ in
                        // Animation for new button
                        UIView.animate(withDuration: 0.1, delay: 0, options: [], animations: {
                            self.viewMapButton.alpha = 1
                        }, completion: nil)
                    })
                })
            })
    }
   
    // this launches the view to see all added documents and option to add them
    @IBAction func viewDocumentButtonClicked()
    {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "VehicleDocumentViewController") as? VehicleDocumentViewController{
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    // this launches the view to see all added expenses and option to add them
    @IBAction func viewExpenseButtonClicked(){
        if let vc = storyboard?.instantiateViewController(withIdentifier: "VehicleExpensesViewController") as? VehicleExpensesViewController{
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    // this launches the view to see all added services and option to add them
    @IBAction func serviceReminderButtonClicked(){
        if let vc = storyboard?.instantiateViewController(withIdentifier: "ServiceReminderViewController") as? ServiceReminderViewController{
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    // this launches the view to see all garages nearby
    @IBAction func findNearbyGaragesButtonClicked(){
        if let vc = storyboard?.instantiateViewController(withIdentifier: "SearchGaragesViewController") as? SearchGaragesViewController{
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    

  

}
