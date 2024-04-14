//
//  VehicleExpensesViewController.swift
//  CarMinder
//
//  Created by Default User on 4/12/24.
//

import UIKit

class VehicleExpensesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let mainDelegate = UIApplication.shared.delegate as! AppDelegate
    @IBOutlet var tableView : UITableView!
    
    @IBAction func addButtonTapped(){
        if let vc = storyboard?.instantiateViewController(withIdentifier: "VehicleExpenseAddViewController") as? VehicleExpenseAddViewController{
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

      
        title = "Vehicle Expenses"

        mainDelegate.readDataFromDatabaseExpenseTable(id: mainDelegate.currentCarId)
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        mainDelegate.readDataFromDatabaseExpenseTable(id: mainDelegate.currentCarId)
        tableView.reloadData()
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainDelegate.expenses.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let tableCell  = tableView.dequeueReusableCell(withIdentifier: "cell") as? DocumentCell ?? DocumentCell(style: .default, reuseIdentifier: "cell")
        
        
        let rowNum = indexPath.row
        
        
        
        tableCell.primaryLabel.text = mainDelegate.expenses[rowNum].title
        tableCell.secondaryLabel.text = mainDelegate.expenses[rowNum].cost?.codingKey.stringValue
        tableCell.accessoryType = .disclosureIndicator
        
        return tableCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // set selectedImagePaths to the current selected row to display in the image collection
        mainDelegate.selectedImagePaths = mainDelegate.expenses[indexPath.row].imagesUrl!
     
        if let vc = storyboard?.instantiateViewController(withIdentifier: "CollectionViewController") as? CollectionViewController{
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    

}
