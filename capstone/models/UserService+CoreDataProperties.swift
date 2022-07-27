//
//  UserService+CoreDataProperties.swift
//  capstone
//
//  Created by Alejandro Morales on 2021-11-30.
//
//

import Foundation
import CoreData


extension UserService {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserService> {
        return NSFetchRequest<UserService>(entityName: "UserService")
    }

    @NSManaged public var user: String?
    @NSManaged public var desc: String?
    @NSManaged public var image: String?
    @NSManaged public var price: Double
    @NSManaged public var other: String?

}

extension UserService : Identifiable {

}
