import Foundation
import CoreData


extension Activity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Activity> {
        return NSFetchRequest<Activity>(entityName: "Activity")
    }

    @NSManaged public var desc: String?
    @NSManaged public var type: String?
    @NSManaged public var date: NSDate?
    @NSManaged public var hour: NSDate?
    @NSManaged public var person: Person?
    @NSManaged public var organization: Organization?
    @NSManaged public var business: Business?

}
