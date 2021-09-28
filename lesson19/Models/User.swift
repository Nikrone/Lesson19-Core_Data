//
//  User+CoreDataClass.swift
//  lesson19
//
//  Created by Evgeniy Nosko on 28.09.21.
//
//

import Foundation
import CoreData

@objc(User)
public class User: NSManagedObject, Identifiable {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var user: String?
}
