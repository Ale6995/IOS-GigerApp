//
//  EditScreenTableViewController.swift
//  capstone
//
//  Created by Alejandro Morales on 2021-12-03.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage

class EditScreenTableViewController: UITableViewController {
    
    var screenType: String = ""
    var postRoute:String = "gigs"
    let db = Firestore.firestore()
    let storageRef = Storage.storage().reference()
    let user=Auth.auth().currentUser
    var gigtoShow:GigModel? = nil
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tittleView: UITextField!
    @IBOutlet weak var descriptionView: UITextView!
    @IBOutlet weak var priceView: UITextView!
    var image: UIImage?
    @IBOutlet weak var otherInfoView: UITextView!
    @IBAction func saveAction(_ sender: Any)  {
        if(screenType != "showG"){
        let tittle = tittleView.text ?? "no tittle"
        let desc = descriptionView.text ?? ""
        let price = priceView.text ?? ""
        let other = otherInfoView.text ?? ""
        let user = user?.email ?? "no user"
        if (image == nil){
            saveData(tittle: tittle, desc: desc, price: price, other: other, usr: user,img: "")}
            else{
                savePhoto(tittle: tittle, desc: desc, price: price, other: other, usr: user)
            }
        }
       
    }
    
    func saveData(tittle:String, desc:String ,price:String ,other:String , usr:String,img:String){
        var ref: DocumentReference? = nil
            
        ref = db.collection(postRoute).addDocument(data: [
            "imageUrl":img,
            "tittle": tittle,
            "description": desc,
            "price": price,
            "other":other,
            "user":usr
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    func savePhoto(tittle:String, desc:String ,price:String ,other:String , usr:String) {
        
        let date = Date()
        let calendar = Calendar.current
        let hour1 = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let year1 = calendar.component(.year, from: date)
        let name = "images/\(hour1)\(minutes)\(year1).jpg"
        // Create a reference to the file you want to upload
        let imgRef = storageRef.child(name)
        
        // Upload the file to the path "images/rivers.jpg"
        _ = imgRef.putData((image?.pngData())!, metadata: nil) { (metadata, error) in
            //          guard let metadata = metadata else {
            //            // Uh-oh, an error occurred!
            //            return
            //          }
            // Metadata contains file metadata such as size, content-type.
            //          let size = metadata.size
            // You can also access to download URL after upload.
             imgRef.downloadURL { (url, error) in
                guard let downloadURL = url else {
                    print("error getting the download url \(error)")
                    return
                }
                print("downloadurl is \(downloadURL)")
                
                 self.saveData(tittle: tittle, desc: desc, price: price, other: other, usr: usr,img: downloadURL.absoluteString)
                return
            }
            
        }
       
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        switch screenType{
        case "add":
            print("add gig")
            postRoute="gigs"
            break
        case "addServ":
            postRoute="servs"
            saveButton.setTitle("Save service", for: .normal)
            print("add service")
        case "showG":
            tittleView.isHidden=true
            self.title=gigtoShow?.tittle
            saveButton.setTitle("Message giger", for: .normal)
            let url = URL(string: (gigtoShow?.image!)!)
            if(url != nil){
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url!)
                if(data != nil){
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: data!)
                }
                }
            }
                
            }
            descriptionView.text=gigtoShow?.desc
            otherInfoView.text=gigtoShow?.other
            priceView.text=gigtoShow?.budget
            
            print("add service")
        case "showS":
            print("add service")
        default:
            print("err")
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if(identifier=="goToChat" && screenType != "showG"){
            return false
        }else{return true}
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      if indexPath.section == 0 && indexPath.row == 0 {
          tableView.deselectRow(at: indexPath, animated: true)
          pickPhoto()
      }
    }




}
extension EditScreenTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func takePhotoWithCamera() {
      let imagePicker = UIImagePickerController()
      imagePicker.sourceType = .camera
      imagePicker.delegate = self
      imagePicker.allowsEditing = true
      present(imagePicker, animated: true, completion: nil)
    }
    
    func choosePhotoFromLibrary() {
      let imagePicker = UIImagePickerController()
      imagePicker.sourceType = .photoLibrary
      imagePicker.delegate = self
      imagePicker.allowsEditing = true
      present(imagePicker, animated: true, completion: nil)
    }
    
    func pickPhoto() {
      if  UIImagePickerController.isSourceTypeAvailable(.camera) {
        showPhotoMenu()
      } else {
        choosePhotoFromLibrary()
      }
    }
    
    func showPhotoMenu() {
      let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
      let actCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
      alert.addAction(actCancel)
      let actPhoto = UIAlertAction(title: "Take Photo", style: .default, handler: { _ in
        self.takePhotoWithCamera()
      })
      alert.addAction(actPhoto)
      let actLibrary = UIAlertAction(title: "Choose From Library", style: .default, handler: { _ in
        self.choosePhotoFromLibrary()
      })
      alert.addAction(actLibrary)
      present(alert, animated: true, completion: nil)
    }
    
    // MARK:- Image Picker Delegates
      func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
          image = info[UIImagePickerController.InfoKey(rawValue: UIImagePickerController.InfoKey.editedImage.rawValue) ] as? UIImage
          
      if let theImage = image {
        show(image: theImage)
          
      }
      tableView.reloadData()
      dismiss(animated: true, completion: nil)
      }
       
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
      dismiss(animated: true, completion: nil)
    }
    func show(image: UIImage) {
        
      imageView.image = image
      imageView.isHidden = false
      imageView.frame = CGRect(x: 10, y: 10, width: 260, height: 260)
//      photoLabel.isHidden = true
    }
  }

