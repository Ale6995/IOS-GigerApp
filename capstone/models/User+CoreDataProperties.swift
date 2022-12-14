//
//  User+CoreDataProperties.swift
//  capstone
//
//  Created by Alejandro Morales on 2021-11-30.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var name: String?
    @NSManaged public var email: String?
    @NSManaged public var phone: String?
    @NSManaged public var isCreator: Bool

}

extension User : Identifiable {

}
