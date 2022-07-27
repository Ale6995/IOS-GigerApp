//
//  HomeTableViewCell.swift
//  capstone
//
//  Created by Alejandro Morales on 2021-12-07.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    var gigsList = Array<GigModel>() {
        didSet{
            print("setting data\(gigsList)")
            collectionView.reloadData()
        }
    }
    
    

    @IBOutlet weak var collectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionView.dataSource=self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
extension HomeTableViewCell:UICollectionViewDataSource,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gigsList.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell=collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! CustomCollectionViewCell
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
    
   

   
    
    
}
