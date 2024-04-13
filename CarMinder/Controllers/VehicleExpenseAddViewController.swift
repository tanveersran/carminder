//
//  VehicleExpenseAddViewController.swift
//  CarMinder
//
//  Created by Default User on 4/1/24.
//

import UIKit
import VisionKit

class VehicleExpenseAddViewController: UIViewController ,UITextFieldDelegate, VNDocumentCameraViewControllerDelegate{
    
    
    let mainDelegate = UIApplication.shared.delegate as! AppDelegate
    @IBOutlet var tfTitle: UITextField!
    @IBOutlet var tfCost: UITextField!
    var imagePicker = UIImagePickerController()
    var currentScannedImagePaths: [String] = []
    var imagesChosen = false;
    
    @IBAction func addDocumentbuttonClicked(){
        
        let expense : Expense = Expense.init()
        let title = tfTitle.text!
        let cost = tfCost.text!
 
        if(!title.isEmpty && !cost.isEmpty && mainDelegate.currentCarId != 0 && imagesChosen){
            expense.initWithData(theRow: 0, theTitle: title, theCost: Int(cost) ?? 0, theImagesUrl: currentScannedImagePaths,theCarId: mainDelegate.currentCarId)
            mainDelegate.insertIntoExpensesTable(expense: expense)
        }
    }

    func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFailWithError error: Error) {
        imagesChosen = false
    }
    
    @IBAction func addImageButtonClicked() {
        let documentScannerViewController = VNDocumentCameraViewController()
        documentScannerViewController.delegate = self
        present(documentScannerViewController, animated: true)
    }
    
    func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
           // Loop through scanned pages
           for pageIndex in 0..<scan.pageCount {
               let image = scan.imageOfPage(at: pageIndex)
               // Save the scanned image to local storage
               saveImage(image: image)
               
           }
           controller.dismiss(animated: true, completion: nil)
       }
       
       func documentCameraViewControllerDidCancel(_ controller: VNDocumentCameraViewController) {
           controller.dismiss(animated: true, completion: nil)
       }
       
       // Function to save image to local storage
    func saveImage(image: UIImage) {
        imagesChosen = true
           if let data = image.jpegData(compressionQuality: 1.0) {
               let fileName = "expenses_\(Date().timeIntervalSince1970).jpg" // Unique
               let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent(fileName)
               do {
                   try data.write(to: fileURL)
                   // appending the strings into arrayß
                   currentScannedImagePaths.append(fileURL.path)
                   print("Image saved successfully at: \(fileURL)")
                  
               } catch {
                   print("Error saving image: \(error.localizedDescription)")
               }
           }
       }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.title = "Vehicle Expenses"
        mainDelegate.readDataFromDatabaseExpenseTable(id: mainDelegate.currentCarId)
    }
}
