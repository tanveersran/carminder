//
//  ViewDocumentsViewController.swift
//  CarMinder
//
//  Created by Default User on 4/1/24.
//

import UIKit

class ViewDocumentsViewController: UIViewController {
    
    let mainDelegate = UIApplication.shared.delegate as! AppDelegate
    @IBOutlet weak var viewDocumentButton: UIButton!
    @IBOutlet weak var viewExpenseButton: UIButton!
    @IBOutlet weak var serviceReminderButton: UIButton!
    @IBOutlet weak var viewMapButton: UIButton!
    @IBOutlet weak var contactNearbyGarages : UIButton!


    override func viewDidLoad() {
        super.viewDidLoad()
        if let car = mainDelegate.cars.first(where: { $0.id == mainDelegate.currentCarId}) {
            title = car.name
        }
        
        viewDocumentButton.alpha = 0
        viewExpenseButton.alpha = 0
        serviceReminderButton.alpha = 0
        viewMapButton.alpha = 0
        contactNearbyGarages.alpha = 0

        UIView.animate(withDuration: 0.2, delay: 0, options: [], animations: {
            self.viewDocumentButton.alpha = 1
        }, completion: { _ in
            UIView.animate(withDuration: 0.1, delay: 0, options: [], animations: {
                self.viewExpenseButton.alpha = 1
            }, completion: { _ in
                UIView.animate(withDuration: 0.1, delay: 0, options: [], animations: {
                    self.serviceReminderButton.alpha = 1
                }, completion: { _ in
                    UIView.animate(withDuration: 0.1, delay: 0, options: [], animations: {
                        self.viewMapButton.alpha = 1
                    }, completion: { _ in
                        // Animation for new button
                        UIView.animate(withDuration: 0.1, delay: 0, options: [], animations: {
                            self.contactNearbyGarages.alpha = 1
                        }, completion: nil)
                    })
                })
            })
        })
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
    @IBAction func findNearbyGaragesButtonClicked(){
        if let vc = storyboard?.instantiateViewController(withIdentifier: "SearchGaragesViewController") as? SearchGaragesViewController{
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    @IBAction func needRepairButtonClicked(){
        if let vc = storyboard?.instantiateViewController(withIdentifier: "WebKitViewController") as? WebKitViewController{
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    

  

}
