//
//  ViewController.swift
//  CarMinder
//
//  Created by Default User on 3/30/24.
// This controller is for the logic and connections to the screen where user can see all vehicles they have and select them
//

import UIKit

class VehicleListViewController: UIViewController , UITableViewDataSource, UITableViewDelegate{
    
    
    // calling the app delegate
    let mainDelegate = UIApplication.shared.delegate as! AppDelegate
    
    // connecting the table view in main
    @IBOutlet var tableView: UITableView!
    
    // this function will run when user clicks the "+" icon to add new vehicle
    @IBAction func addButtonClicked(){
        // this will navigate to the vehicle add view controller upon button click
        if let vc = storyboard?.instantiateViewController(withIdentifier: "VehicleAddViewController") as? VehicleAddViewController{
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

    // this is run when the view loads. it will set the styling for the page.
    override func viewDidLoad() {
        super.viewDidLoad()
        mainDelegate.readDataFromDatabase()
   
        tableView.reloadData()
        navigationController?.navigationBar.tintColor = UIColor.red
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonClicked))
        navigationItem.rightBarButtonItem = addButton
        
        title = "My Cars"
        
        let backgroundImage = UIImage(named: "background.jpeg")
        let backgroundImageView = UIImageView(image: backgroundImage)
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.alpha = 0.85
        tableView.backgroundView = backgroundImageView
    }
    
    // when the view appears, the data is reloaded and fetched from the database
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        mainDelegate.readDataFromDatabase()
        tableView.reloadData()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
   
    // this is used to set the number of rows our tableview has
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainDelegate.cars.count
    }

 
    // this is setting the height of our table
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
  
    // this is to set data for individual cells in the table
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let tableCell  = tableView.dequeueReusableCell(withIdentifier: "cell") as? SiteCell ?? SiteCell(style: .default, reuseIdentifier: "cell")
        
        let rowNum = indexPath.row
        tableCell.primaryLabel.text = mainDelegate.cars[rowNum].name
        tableCell.secondaryLabel.text = mainDelegate.cars[rowNum].vin
        tableCell.myImageView.image = UIImage(named: mainDelegate.cars[rowNum].image!)
        
    tableCell.accessoryType = .disclosureIndicator
        
        return tableCell
    }
    
    // this runs when a row is selected, it sets the current car to the one selected in app delegate and loads the view for all document types related to the car
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let rowNum = indexPath.row // keeping track of the selected row number
     
        mainDelegate.currentCarId = mainDelegate.cars[rowNum].id
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "ViewDocumentsViewController") as? ViewDocumentsViewController{
            self.navigationController?.pushViewController(vc, animated: true)
        }

        
    }
    
    // this sets the delete action on swipe to remove the cars
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
 
        // this, upon click of delete button will remove all documents, expenses and reminders related to the car we are deleting
        let deleteAction = UIContextualAction(style: .normal, title: "Delete", handler:
        { ac, view, success in
           if( self.mainDelegate.deleteFromDocumentsTable(documentId: self.mainDelegate.cars[indexPath.row].id!) &&
               self.mainDelegate.deleteFromExpensesTable(expenseId: self.mainDelegate.cars[indexPath.row].id!) &&
               self.mainDelegate.deleteFromReminderTable(reminderId: self.mainDelegate.cars[indexPath.row].id!))
            {
               if( self.mainDelegate.deleteFromCarsTable(carId: self.mainDelegate.cars[indexPath.row].id!)){
                   self.mainDelegate.readDataFromDatabase()
                   tableView.reloadData()
               }
           }
            
            success(true)
        }
        )
        deleteAction.backgroundColor = .red
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    
    // this is to the function that can be used to go back to home vc
    @IBAction func unwindtoHomeVC(sender : UIStoryboardSegue){
        
    }


}

