//
//  ViewController.swift
//  CarMinder
//
//  Created by Default User on 3/30/24.
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
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        mainDelegate.readDataFromDatabase()
        tableView.reloadData()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // step 12 - add table methods
    // step 12a - for number of table cells
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainDelegate.cars.count
    }

    // step 12b - how thick each cell is
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    // step 12c - what should go in each cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let tableCell  = tableView.dequeueReusableCell(withIdentifier: "cell") as? SiteCell ?? SiteCell(style: .default, reuseIdentifier: "cell")
        
        
        let rowNum = indexPath.row
        tableCell.primaryLabel.text = mainDelegate.cars[rowNum].name
        tableCell.secondaryLabel.text = mainDelegate.cars[rowNum].vin
        tableCell.myImageView.image = UIImage(named: mainDelegate.cars[rowNum].image!)
            
        

        
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
    
    
    
    @IBAction func unwindtoHomeVC(sender : UIStoryboardSegue){
        
    }


}

