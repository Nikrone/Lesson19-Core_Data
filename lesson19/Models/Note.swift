//
//  Note+CoreDataClass.swift
//  lesson19
//
//  Created by Evgeniy Nosko on 28.09.21.
//
//

import Foundation
import CoreData

@objc(Note)
public class Note: NSManagedObject, Identifiable {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var text: String?
    @NSManaged public var creationDate: NSObject?
    @NSManaged public var user: User?
}
