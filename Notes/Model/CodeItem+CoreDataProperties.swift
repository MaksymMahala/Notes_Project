//
//  CodeItem+CoreDataProperties.swift
//  
//
//  Created by Maksym on 23.11.2023.
//
//

import Foundation
import CoreData


extension CodeItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CodeItem> {
        return NSFetchRequest<CodeItem>(entityName: "CodeItem")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var code: String?

}
