import Foundation
import CoreData


extension Business {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Business> {
        return NSFetchRequest<Business>(entityName: "Business")
    }

    @NSManaged public var tittle: String?
    @NSManaged public var desc: String?
    @NSManaged public var value: Double
    @NSManaged public var creation_date: NSDate?
    @NSManaged public var status: Bool
    @NSManaged public var organization: NSSet?
    @NSManaged public var person: NSSet?

}

// MARK: Generated accessors for organization
extension Business {

    @objc(addOrganizationObject:)
    @NSManaged public func addToOrganization(_ value: Organization)

    @objc(removeOrganizationObject:)
    @NSManaged public func removeFromOrganization(_ value: Organization)

    @objc(addOrganization:)
    @NSManaged public func addToOrganization(_ values: NSSet)

    @objc(removeOrganization:)
    @NSManaged public func removeFromOrganization(_ values: NSSet)

}

// MARK: Generated accessors for person
extension Business {

    @objc(addPersonObject:)
    @NSManaged public func addToPerson(_ value: Person)

    @objc(removePersonObject:)
    @NSManaged public func removeFromPerson(_ value: Person)

    @objc(addPerson:)
    @NSManaged public func addToPerson(_ values: NSSet)

    @objc(removePerson:)
    @NSManaged public func removeFromPerson(_ values: NSSet)

}
