//
//  Person.swift
//  Activity manager
//
//  Created by Mario Vizcaino on 5/22/17.
//  Copyright © 2017 None. All rights reserved.
//

import Foundation
import CoreData

class PersonService{
    
    var context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext){
        self.context = context
    }
    
    // Creates a new Person
    func create(name: String, phone: NSNumber, email: String) -> Person {
        
        let newItem = NSEntityDescription.insertNewObject(forEntityName: Person.entityName, into: context) as! Person
        
        newItem.name = name
        newItem.phone = Int16(phone)
        newItem.email = email
        
        return newItem
    }
    
    // Gets a person by id
    func getById(id: NSManagedObjectID) -> Person? {
        return context.object(with: id) as? Person
    }
    
    // Gets all.
    func getAll() -> [Person]{
        return get(withPredicate: NSPredicate(value:true))
    }
    
    // Gets all that fulfill the specified predicate.
    // Predicates examples:
    // - NSPredicate(format: "name == %@", "Juan Carlos")
    // - NSPredicate(format: "name contains %@", "Juan")
    func get(withPredicate queryPredicate: NSPredicate) -> [Person]{
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Person.entityName)
        
        fetchRequest.predicate = queryPredicate
        
        do {
            let response = try context.fetch(fetchRequest)
            return response as! [Person]
            
        } catch let error as NSError {
            // failure
            print(error)
            return [Person]()
        }
    }
    
    // Updates a person
    func update(updatedPerson: Person){
        if let person = getById(id: updatedPerson.objectID){
            person.name = updatedPerson.name
            person.email = updatedPerson.email
            person.phone = updatedPerson.phone
        }
    }
    
    // Deletes a person
    func delete(id: NSManagedObjectID){
        if let personToDelete = getById(id: id){
            context.delete(personToDelete)
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
