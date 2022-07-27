

import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore



class ServsViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var servsList = Array<GigModel>()
    let db = Firestore.firestore()
    let currentUser=Auth.auth().currentUser
    
            
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        if(  currentUser == nil ){
            
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let newViewController = storyBoard.instantiateViewController(withIdentifier: "loginFlow")
                newViewController.isModalInPresentation=true
                self.present(newViewController, animated: true, completion: nil)
    //            self.show(newViewController, sender: nil)
                
        }else{
            loadData()
            
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? EditScreenTableViewController {
                        viewController.screenType = "addServ"
                    }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension ServsViewController:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return servsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell=collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! CustomCollectionViewCell
        let gradient:CAGradientLayer = CAGradientLayer()
        gradient.frame.size = cell.bounds.size
        gradient.colors = [UIColor.init(named: "CardColor")!.cgColor,UIColor.init(named: "CardColorEnd")!.cgColor] //Or any colors
            cell.layer.insertSublayer(gradient, at: 0)
        cell.layer.cornerRadius = 15
        cell.cellImage.layer.cornerRadius = 15
        
        cell.tittleLabel.text=servsList[indexPath.row].tittle
        cell.creatorLabel.text=servsList[indexPath.row].user
        cell.priceLabel.text=servsList[indexPath.row].budget
        
        let url = URL(string: servsList[indexPath.row].image!)
        if(url != nil){
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url! )
            if(data != nil){
            DispatchQueue.main.async {
                cell.cellImage.image = UIImage(data: data!)
            }
                
            }
        }
            
        }
        return cell
    }
    func loadData(){
        let docsRef = db.collection("servs")
        docsRef.whereField("user", isEqualTo: currentUser!.email!)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    self.servsList.removeAll()
                    for document in querySnapshot!.documents {
                        let dict=document.data()
                        let gig = GigModel();
                        gig.tittle=dict[GigModel.CodingKeys.tittle.rawValue] as? String ?? ""
                        gig.image=dict[GigModel.CodingKeys.image.rawValue] as? String ?? ""
                        gig.budget=dict[GigModel.CodingKeys.budget.rawValue] as? String ?? ""
                        gig.desc=dict[GigModel.CodingKeys.desc.rawValue] as? String ?? ""
                        gig.other=dict[GigModel.CodingKeys.other.rawValue] as? String ?? ""
                        gig.user=dict[GigModel.CodingKeys.user.rawValue] as? String ?? ""
                        self.servsList.append(gig)
                        
                        print("gig: \(dict)")
                    }
                    self.collectionView.reloadData();
                }
        }
        
    }
    
}

