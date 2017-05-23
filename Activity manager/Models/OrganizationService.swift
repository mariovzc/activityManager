import Foundation
import CoreData

class OrganizationService{
    
    var context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext){
        self.context = context
    }
    
    // Creates a new Organization
    func create(name: String, phone: NSNumber, address: String) -> Organization {
        
        let newItem = NSEntityDescription.insertNewObject(forEntityName: Organization.entityName, into: context) as! Organization
        
        newItem.name = name
        newItem.phone = Int16(phone)
        newItem.address = address
        
        return newItem
    }
    
    // Gets a Organization by id
    func getById(id: NSManagedObjectID) -> Organization? {
        return context.object(with: id) as? Organization
    }
    
    // Gets all.
    func getAll() -> [Organization]{
        return get(withPredicate: NSPredicate(value:true))
    }
    
    func get(withPredicate queryPredicate: NSPredicate) -> [Organization]{
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Organization.entityName)
        
        fetchRequest.predicate = queryPredicate
        
        do {
            let response = try context.fetch(fetchRequest)
            return response as! [Organization]
            
        } catch let error as NSError {
            // failure
            print(error)
            return [Organization]()
        }
    }
    
    // Updates a Organization
    func update(updatedOrganization: Organization){
        if let organization = getById(id: updatedOrganization.objectID){
            organization.name = updatedOrganization.name
            organization.address = updatedOrganization.address
            organization.phone = updatedOrganization.phone
        }
    }
    
    // Deletes a Organization
    func delete(id: NSManagedObjectID){
        if let organizationToDelete = getById(id: id){
            context.delete(organizationToDelete)
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
