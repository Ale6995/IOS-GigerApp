//
//  Gigs+CoreDataClass.swift
//  capstone
//
//  Created by Alejandro Morales on 2021-11-30.
//
//

import Foundation
import CoreData
import FirebaseFirestoreSwift


public class Gigs{
    init(value:[String : Any])  {
        self.image=value[Gigs.CodingKeys.image]
        self.budget=valueGigs.CodingKeys.budget]
        self.desc=value[Gigs.CodingKeys.desc]
        self.other=value[Gigs.CodingKeys.other]
        self.user=value[Gigs.CodingKeys.user]
       }
    

}
extension Gigs {
    enum CodingKeys: String,CodingKey{
        case image = "imageUrl"
        case budget = "price"
        case desc = "description"
        case other
        case user
    }
     
    
}
