//
//  Car+CoreDataProperties.swift
//  CarsSwiftUI
//
//  Created by Дмитрий Геращенко on 22.06.2021.
//
//

import Foundation
import CoreData


extension Car {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Car> {
        return NSFetchRequest<Car>(entityName: "Car")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var manufacturer: String?
    @NSManaged public var model: String?
    @NSManaged public var year: Int16
    @NSManaged public var carDescription: String?

}

extension Car : Identifiable {

}
