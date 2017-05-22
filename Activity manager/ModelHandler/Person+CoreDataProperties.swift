//
//  Person+CoreDataProperties.swift
//  Activity manager
//
//  Created by Giancarlo Valencia on 5/22/17.
//  Copyright © 2017 None. All rights reserved.
//

import Foundation
import CoreData


extension Person {


    @NSManaged public var name: String?
    @NSManaged public var email: String?
    @NSManaged public var phone: Int16

}
