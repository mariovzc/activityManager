import Foundation
import CoreData

class BusinessService{
    
    var context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext){
        self.context = context
    }
    
    // Creates a new Business
    func create(tittle: String, description: String, value: Double, date: NSDate, organization: Organization, person: Person, status: Bool) -> Business {
        
        let newItem = NSEntityDescription.insertNewObject(forEntityName: Business.entityName, into: context) as! Business
        newItem.tittle = tittle
        newItem.desc = description
        newItem.value = value
        newItem.creation_date = date
        newItem.status = status
        newItem.addToOrganization(organization)
        newItem.addToPerson(person)
        return newItem
    }
    
    // Gets a Business by id
    func getById(id: NSManagedObjectID) -> Business? {
        return context.object(with: id) as? Business
    }
    
    // Gets all.
    func getAll() -> [Business]{
        return get(withPredicate: NSPredicate(value:true))
    }
    
    func get(withPredicate queryPredicate: NSPredicate) -> [Business]{
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Business.entityName)
        
        fetchRequest.predicate = queryPredicate
        
        do {
            let response = try context.fetch(fetchRequest)
            return response as! [Business]
            
        } catch let error as NSError {
            // failure
            print(error)
            return [Business]()
        }
    }
    
    // Updates a Business
    func update(updatedBusiness: Business){
        if let business = getById(id: updatedBusiness.objectID){
            business.tittle = updatedBusiness.tittle            
            business.desc = updatedBusiness.desc
            business.value = updatedBusiness.value
            business.creation_date = updatedBusiness.creation_date
            business.status = updatedBusiness.status
            business.removeFromOrganization(business.organization!)
            business.addToOrganization(updatedBusiness.organization!)
            business.removeFromPerson(business.person!)
            business.addToPerson(updatedBusiness.person!)
            
        }
    }
    
    // Deletes a Business
    func delete(id: NSManagedObjectID){
        if let BusinessToDelete = getById(id: id){
            context.delete(BusinessToDelete)
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
