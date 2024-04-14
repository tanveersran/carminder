//
//  VehicleDocumentAddViewController.swift
//  CarMinder
//
//  Created by Default User on 4/1/24.
//

import UIKit
import VisionKit

class VehicleDocumentAddViewController: UIViewController , UITextFieldDelegate, VNDocumentCameraViewControllerDelegate{
    
    @IBOutlet var tfTitle: UITextField!
    @IBOutlet var datePicker: UIDatePicker!
    var imagesChosen = false;
    let mainDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var currentScannedImagePaths: [String] = []
    
    @IBAction func addDocumentbuttonClicked(){
        
        let document : Document = Document.init()
        let title = tfTitle.text!
        let date = datePicker.date
        
        if(!title.isEmpty && !date.description.isEmpty && mainDelegate.currentCarId != 0 ){ //&& imagesChosen
            document.initWithData(theRow: 0, theTitle: title, thePaperDate: date, theImagesUrl: currentScannedImagePaths,theCarId: mainDelegate.currentCarId)
           if(
               mainDelegate.insertIntoDocumentsTable(document: document)
           ){
               navigationController?.popViewController(animated: true)
               }
           }
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
           if let data = image.jpegData(compressionQuality: 1.0) {
               let fileName = "documents_\(Date().timeIntervalSince1970).jpg" // Unique
               let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent(fileName)
               do {
                   try data.write(to: fileURL)
                   // appending the strings into arrayß
                   currentScannedImagePaths.append(fileURL.path)
                   imagesChosen = true;
                   print("Image saved successfully at: \(fileURL)")
                  
               } catch {
                   imagesChosen = false;
                   print("Error saving image: \(error.localizedDescription)")
               }
           }
       }
    
    func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFailWithError error: Error) {
        imagesChosen = false;
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Vehicle documents"
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        mainDelegate.readDataFromDatabaseDocumentsTable(id: mainDelegate.currentCarId)
    }
    
    
   
}
