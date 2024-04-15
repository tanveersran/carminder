//
//  ServiceReminderAddViewController.swift
//  CarMinder
//
//  Created by Aditya on 4/13/24.
//  This controller is used to add a service reminder for the car
//

import UIKit

class ServiceReminderAddViewController: UIViewController ,UITextFieldDelegate{
    
    @IBOutlet var tfTitle: UITextField!
    @IBOutlet var tfDueDistance : UITextField!
    @IBOutlet var datePicker: UIDatePicker!
    let mainDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBAction func addDocumentbuttonClicked(){
        
        let reminder : Reminder = Reminder.init()
        let title = tfTitle.text!
        let distance = tfDueDistance.text!
        let dueDistance = Int(tfDueDistance.text!) ?? 0
        let date = datePicker.date
        
        if(!title.isEmpty && !date.description.isEmpty && !distance.isEmpty && mainDelegate.currentCarId != 0){
            reminder.initWithData(theRow: 0, theTitle: title, theDueDate: date, theDueDistance: dueDistance, theCarId: mainDelegate.currentCarId)
            if(mainDelegate.insertIntoRemindersTable(reminder: reminder)){
                
                navigationController?.popViewController(animated: true)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add a Reminder"

    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
