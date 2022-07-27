//
//  HomeViewController.swift
//  capstone
//
//  Created by Alejandro Morales on 2021-11-23.
//

import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore


class HomeViewController: UITableViewController {
    
    var gigsList = Array<GigModel>()
    var servsList = Array<GigModel>()
    let db = Firestore.firestore()
    
    let tableViewCellIdentifier = "HomeTableCell"
    let tableViewHeaderIdentifier = "HomeTableHeader"
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        self.title="Giger"
        let headerNib = UINib(nibName: "TableViewHeaderView", bundle: nil)
        // Do any additional setup after loading the view.
        tableView.register(headerNib, forHeaderFooterViewReuseIdentifier: tableViewHeaderIdentifier)
    }
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellIdentifier, for: indexPath) as! HomeTableViewCell
        
        if(indexPath.section == 0){
            cell.gigsList=gigsList
        }else{
            cell.gigsList=servsList
        }
        
        return cell
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        40
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: tableViewHeaderIdentifier) as! TableViewHeaderView
        if(section==1){
        headerView.selLabel.text = "Popular Services"
        }else{
        headerView.selLabel.text = "Popular Gigs"
        }
        
        return headerView
    }
    
    
    func loadData(){
        let gigsRef = db.collection("gigs")
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
                    self.tableView.reloadData()
                }
        }
        let servsRef = db.collection("servs")
        servsRef.getDocuments() { (querySnapshot, err) in
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
                          
                    }
                    self.tableView.reloadData();
                }
        }

        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? EditScreenTableViewController {
            
            viewController.gigtoShow=gigsList[sender as! Int]
                        viewController.screenType = "showG"
                    }
    }
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if(sender as? Int != nil ){
            return true
        }else{
            return false
        }
    }
    
    

}
extension HomeViewController:UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetail", sender: indexPath.row)
    }
}
