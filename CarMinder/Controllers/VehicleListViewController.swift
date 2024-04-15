//
//  VehicleExpensesViewController.swift
//  CarMinder
//
//  Created by Birarpanjot Singh on 4/12/24.
//  This file is used to show the all the list of vehicles which are added by the user.
//



import UIKit

class VehicleListViewController: UIViewController , UITableViewDataSource, UITableViewDelegate{
    
    
    
    let mainDelegate = UIApplication.shared.delegate as! AppDelegate
    @IBOutlet var tableView: UITableView!
    var currentRow : Int!
    @IBAction func addButtonClicked(){
        if let vc = storyboard?.instantiateViewController(withIdentifier: "VehicleAddViewController") as? VehicleAddViewController{
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

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
        backgroundImageView.alpha = 0.65
        tableView.backgroundView = backgroundImageView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        mainDelegate.readDataFromDatabase()
        tableView.reloadData()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainDelegate.cars.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let tableCell  = tableView.dequeueReusableCell(withIdentifier: "cell") as? SiteCell ?? SiteCell(style: .default, reuseIdentifier: "cell")
        
        
        let rowNum = indexPath.row
        tableCell.primaryLabel.text = mainDelegate.cars[rowNum].name
        tableCell.secondaryLabel.text = "VIN " + mainDelegate.cars[rowNum].vin!
        tableCell.myImageView.image = UIImage(named: mainDelegate.cars[rowNum].image!)
        tableCell.backgroundColor = .clear

        tableCell.accessoryType = .disclosureIndicator
        
        return tableCell
    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let rowNum = indexPath.row
     
        mainDelegate.currentCarId = mainDelegate.cars[rowNum].id
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "ViewDocumentsViewController") as? ViewDocumentsViewController{
            self.navigationController?.pushViewController(vc, animated: true)
        }

        
    }
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
 
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
        deleteAction.backgroundColor = UIColor.blue.withAlphaComponent(0.5) // Adjust the alpha value as needed
            
            let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
            configuration.performsFirstActionWithFullSwipe = false
        deleteAction.backgroundColor = .red
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
   
    
    
    @IBAction func unwindtoHomeVC(sender : UIStoryboardSegue){
        
    }


}

