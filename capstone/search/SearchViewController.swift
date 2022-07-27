//
//  SearchViewController.swift
//  capstone
//
//  Created by Alejandro Morales on 2021-11-24.
//

import UIKit
import FirebaseFirestore

private let reuseIdentifier = "collectionCell"

class SearchViewController: UIViewController,UICollectionViewDataSource {
    
    let db = Firestore.firestore()
    var gigsList = Array<GigModel>()
    var searchby = "gigs"
    var activeSearch = false;
    var searchVal=""
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBAction func changeSearch(_ sender: Any) {
        if(searchby=="gigs"){
            searchby="servs"
        }else{
            searchby="gigs"
        }
        if(activeSearch){
            searchData()
        }else{
            loadData()
        }
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        
    }

    
//     MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    



     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
         return gigsList.count
    }

     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CustomCollectionViewCell
         let gradient:CAGradientLayer = CAGradientLayer()
         gradient.frame.size = cell.bounds.size
         gradient.colors = [UIColor.init(named: "CardColor")!.cgColor,UIColor.init(named: "CardColorEnd")!.cgColor] //Or any colors
             cell.layer.insertSublayer(gradient, at: 0)
         cell.layer.cornerRadius = 15
         cell.cellImage.layer.cornerRadius = 15
         
         cell.tittleLabel.text=gigsList[indexPath.row].tittle
         cell.creatorLabel.text=gigsList[indexPath.row].user
         cell.priceLabel.text=gigsList[indexPath.row].budget
         
         let url = URL(string: gigsList[indexPath.row].image!)
         if(url != nil){
         DispatchQueue.global().async {
             let data = try? Data(contentsOf: url!)
             if(data != nil){
             DispatchQueue.main.async {
                 cell.cellImage.image = UIImage(data: data!)
             }
                 
             }
         }
             
         }
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}

extension SearchViewController{
    func loadData(){
        let gigsRef = db.collection(searchby)
        gigsRef.getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    self.gigsList.removeAll()
                    for document in querySnapshot!.documents {
                        let dict=document.data()
                        let gig = GigModel();
                        gig.tittle=dict[GigModel.CodingKeys.tittle.rawValue] as? String ?? ""
                        gig.image=dict[GigModel.CodingKeys.image.rawValue] as? String ?? ""
                        gig.budget=dict[GigModel.CodingKeys.budget.rawValue] as? String ?? ""
                        gig.desc=dict[GigModel.CodingKeys.desc.rawValue] as? String ?? ""
                        gig.other=dict[GigModel.CodingKeys.other.rawValue] as? String ?? ""
                        gig.user=dict[GigModel.CodingKeys.user.rawValue] as? String ?? ""
                        self.gigsList.append(gig)
                        
                    }
                    self.collectionView.reloadData()
                }
        }
//        self.tableView.reloadData();
        
    }
    func searchData(){
        let gigsRef = db.collection(searchby)
        gigsRef.whereField("tittle", in: [searchVal]).getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    self.gigsList.removeAll()
                    for document in querySnapshot!.documents {
                        let dict=document.data()
                        let gig = GigModel();
                        gig.tittle=dict[GigModel.CodingKeys.tittle.rawValue] as? String ?? ""
                        gig.image=dict[GigModel.CodingKeys.image.rawValue] as? String ?? ""
                        gig.budget=dict[GigModel.CodingKeys.budget.rawValue] as? String ?? ""
                        gig.desc=dict[GigModel.CodingKeys.desc.rawValue] as? String ?? ""
                        gig.other=dict[GigModel.CodingKeys.other.rawValue] as? String ?? ""
                        gig.user=dict[GigModel.CodingKeys.user.rawValue] as? String ?? ""
                        self.gigsList.append(gig)
                        
                    }
                    self.collectionView.reloadData()
                }
        }
//        self.tableView.reloadData();
        
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
      print("The search text is: '\(searchBar.text!)'")
        if searchBar.text != "" {
            searchVal=searchBar.text!
            activeSearch=true
            searchData()
            } else{
                activeSearch=false
            loadData()
        }
            
        searchBar.resignFirstResponder()
    }
  }
