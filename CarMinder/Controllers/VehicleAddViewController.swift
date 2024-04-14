import UIKit

class VehicleAddViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var tfName : UITextField!
    @IBOutlet var tfVin : UITextField!
    var currentScannedImagePath: String!
    let mainDelegate = UIApplication.shared.delegate as! AppDelegate
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Add Vehicle"
        imagePicker.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func addImageButtonClicked(_ sender: UIButton) {
        let alert = UIAlertController(title: "Add Image", message: nil, preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "Take Photo", style: .default) { action in
            self.openCamera()
        }
        let galleryAction = UIAlertAction(title: "Choose from Library", style: .default) { action in
            self.openPhotoLibrary()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(cameraAction)
        alert.addAction(galleryAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
            present(imagePicker, animated: true, completion: nil)
        } else {
            print("Camera not available")
        }
    }
    
    func openPhotoLibrary() {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    // MARK: - UIImagePickerControllerDelegate Methods
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            if let data = selectedImage.jpegData(compressionQuality: 1.0) {
                let fileName = "carImage_\(Date().timeIntervalSince1970).jpg" // Unique
                let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent(fileName)
                do {
                    try data.write(to: fileURL)
                  
                    currentScannedImagePath = fileURL.path
                    print("Image saved successfully at: \(fileURL)")
                   
                } catch {
                    print("Error saving image: \(error.localizedDescription)")
                }
            }
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func submitButtonClicked(_ sender: UIButton){
        let car : Car = Car.init()
        
        car.initWithData(theRow: 0, theName: tfName.text!, theVin: tfVin.text!, theImage:  currentScannedImagePath! )
        
        if(mainDelegate.insertIntoDatabase(car: car)){
            if let vc = storyboard?.instantiateViewController(withIdentifier: "VehicleListViewController") as? VehicleListViewController{
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}
