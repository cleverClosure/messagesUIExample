//
//  Message+CoreDataProperties.swift
//  DUI0013 messenger
//
//  Created by Tim on 02.07.17.
//  Copyright © 2017 Tim. All rights reserved.
//

import Foundation
import CoreData


extension Message {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Message> {
        return NSFetchRequest<Message>(entityName: "Message")
    }

    @NSManaged public var text: String?
    @NSManaged public var date: NSDate?
    @NSManaged public var friend: Friend?
    @NSManaged public var isSender: NSNumber?
}
