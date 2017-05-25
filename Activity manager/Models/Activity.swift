import Foundation
import CoreData

class ActivityService{
    
    var context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext){
        self.context = context
    }
    
    func create(desc: String, type: String, hour: NSDate, date: NSDate, organization: Organization, business: Business,  person: Person) -> Activity {
        
        let newItem = NSEntityDescription.insertNewObject(forEntityName: Activity.entityName, into: context) as! Activity
        newItem.desc = desc
        newItem.type = type
        newItem.date = date
        newItem.hour = hour
        newItem.organization = organization
        newItem.business = business
        newItem.person = person
        return newItem
    }
    
    func getById(id: NSManagedObjectID) -> Activity? {
        return context.object(with: id) as? Activity
    }
    
    func getAll() -> [Activity]{
        return get(withPredicate: NSPredicate(value:true))
    }
    
    func get(withPredicate queryPredicate: NSPredicate) -> [Activity]{
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Activity.entityName)
        
        fetchRequest.predicate = queryPredicate
        
        do {
            let response = try context.fetch(fetchRequest)
            return response as! [Activity]
            
        } catch let error as NSError {
            // failure
            print(error)
            return [Activity]()
        }
    }

    func update(updatedActivity: Activity){
        if let activity = getById(id: updatedActivity.objectID){
            activity.desc = updatedActivity.desc
            activity.type = updatedActivity.type
            activity.date = updatedActivity.date
            activity.hour = updatedActivity.hour
            activity.person = updatedActivity.person
            activity.organization = updatedActivity.organization
            activity.business = updatedActivity.business
        }
    }
    
    // Deletes a Business
    func delete(id: NSManagedObjectID){
        if let ActivityToDelete = getById(id: id){
            context.delete(ActivityToDelete)
        }
    }
    
    // Saves all changes
    func saveChanges(){
        do{
            try context.save()
        } catch let error as NSError {
            // failure
            print(error)
        }
    }
}
