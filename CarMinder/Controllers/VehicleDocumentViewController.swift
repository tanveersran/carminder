//
//  VehicleDocumentViewController.swift
//  CarMinder
//
//  Created by Default User on 4/1/24.
//

import UIKit

class VehicleDocumentViewController: UIViewController , UITableViewDataSource, UITableViewDelegate {
    
    let mainDelegate = UIApplication.shared.delegate as! AppDelegate
    @IBOutlet var tableView : UITableView!
    
    @IBAction func addButtonTapped(){
        if let vc = storyboard?.instantiateViewController(withIdentifier: "VehicleDocumentAddViewController") as? VehicleDocumentAddViewController{
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Vehicle Documents"
        mainDelegate.readDataFromDatabaseDocumentsTable(id: mainDelegate.currentCarId)
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        mainDelegate.readDataFromDatabaseDocumentsTable(id: mainDelegate.currentCarId)
        tableView.reloadData()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainDelegate.documents.count
    }

    // step 12b - how thick each cell is
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    // step 12c - what should go in each cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let tableCell  = tableView.dequeueReusableCell(withIdentifier: "cell") as? DocumentCell ?? DocumentCell(style: .default, reuseIdentifier: "cell")
        
        
        let rowNum = indexPath.row
        let date = mainDelegate.documents[rowNum].paperDate
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: date!)
        
        
        tableCell.primaryLabel.text = mainDelegate.documents[rowNum].title
        tableCell.secondaryLabel.text = dateString
            

        
    tableCell.accessoryType = .disclosureIndicator
        
        return tableCell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // set selectedImagePaths to the current selected row to display in the image collection
        mainDelegate.selectedImagePaths = mainDelegate.documents[indexPath.row].imagesUrl!
     
        if let vc = storyboard?.instantiateViewController(withIdentifier: "CollectionViewController") as? CollectionViewController{
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
 
        let deleteAction = UIContextualAction(style: .normal, title: "Delete", handler:
        { ac, view, success in
            if(self.mainDelegate.deleteFromDocumentsTable(documentId: self.mainDelegate.documents[indexPath.row].id!)){
                self.mainDelegate.readDataFromDatabaseDocumentsTable(id: self.mainDelegate.currentCarId)
                self.tableView.reloadData()
            }
            success(true)
        }
        )
        deleteAction.backgroundColor = .red
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }

}
