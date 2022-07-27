//
//  GigModel.swift
//  capstone
//
//  Created by Alejandro Morales on 2021-12-06.
//

import Foundation

public class GigModel{
    public var tittle: String?
     public var image: String?
     public var budget: String?
     public var desc: String?
    public var other: String?
     public var user: String?
    
    enum CodingKeys: String,CodingKey{
        case tittle 
        case image = "imageUrl"
        case budget = "price"
        case desc = "description"
        case other
        case user
    }
//    init(value:[String : Any])  {
//        self.image=value[GigModel.CodingKeys.image.rawValue] as? String ?? ""
//        self.budget=value[GigModel.CodingKeys.budget.rawValue] as? String ?? ""
//        self.desc=value[GigModel.CodingKeys.desc.rawValue] as? String ?? ""
//        self.other=value[GigModel.CodingKeys.other.rawValue] as? String ?? ""
//        self.user=value[GigModel.CodingKeys.user.rawValue] as? String ?? ""
//       }
}
