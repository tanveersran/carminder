//
//  ServiceReminderViewController.swift
//  CarMinder
//
//  Created by Default User on 4/13/24.
//

import UIKit

class ServiceReminderViewController: UIViewController,  UITableViewDataSource, UITableViewDelegate {
    
    let mainDelegate = UIApplication.shared.delegate as! AppDelegate
    @IBOutlet var tableView : UITableView!
    
    @IBAction func addButtonTapped(){
        if let vc = storyboard?.instantiateViewController(withIdentifier: "ServiceReminderAddViewController") as? ServiceReminderAddViewController{
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Service Reminders"

        mainDelegate.readDataFromDatabaseRemindersTable(id: mainDelegate.currentCarId)
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
       

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainDelegate.reminders.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let tableCell  = tableView.dequeueReusableCell(withIdentifier: "cell") as? DocumentCell ?? DocumentCell(style: .default, reuseIdentifier: "cell")
        
        let rowNum = indexPath.row
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let dateString = dateFormatter.string(from: (mainDelegate.reminders[rowNum].dueDate!) as Date)
        
        tableCell.primaryLabel.text = mainDelegate.reminders[rowNum].title
        tableCell.secondaryLabel.text = mainDelegate.reminders[rowNum].dueDistance?.codingKey.stringValue
        tableCell.thirdLabel.text = dateString
        tableCell.accessoryType = .disclosureIndicator
        
        return tableCell
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
 
        let deleteAction = UIContextualAction(style: .normal, title: "Delete", handler:
        { ac, view, success in
            if(self.mainDelegate.deleteFromReminderTable(reminderId: self.mainDelegate.reminders[indexPath.row].id!)){
                self.mainDelegate.readDataFromDatabaseRemindersTable(id: self.mainDelegate.currentCarId)
                self.tableView.reloadData()
            }
            success(true)
        }
        )
        deleteAction.backgroundColor = .red
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        mainDelegate.readDataFromDatabaseRemindersTable(id: mainDelegate.currentCarId)
        tableView.reloadData()
        
    }
    

  

}
