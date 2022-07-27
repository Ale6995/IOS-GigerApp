//
//  Gigs+CoreDataProperties.swift
//  capstone
//
//  Created by Alejandro Morales on 2021-11-30.
//
//

import Foundation
import CoreData


extension Gigs {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Gigs> {
        return NSFetchRequest<Gigs>(entityName: "Gigs")
    }

    @NSManaged public var image: String?
    @NSManaged public var budget: Double
    @NSManaged public var desc: String?
    @NSManaged public var other: String?
    @NSManaged public var user: String?

}

extension Gigs : Identifiable {

}
