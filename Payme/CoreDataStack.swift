//
//  CoreDataStack.swift
//  ShoutOut
//
//  Created by Muraino Yakubu on 5/21/20.
//  Copyright © 2020 pluralsight. All rights reserved.
//

import Foundation
import CoreData

func createMainContext()-> NSManagedObjectContext{
    
    
    

    //initialise the NSManageObject
    
    //get bundle url
    let modelUrl = Bundle.main.url(forResource: "Payme", withExtension: "momd")
    
    guard let model = NSManagedObjectModel(contentsOf: modelUrl!) else {fatalError("model not found")}
    
    
    //Configure NSPersistenceCordinate with NSPersistenceStore
    let psc = NSPersistentStoreCoordinator(managedObjectModel: model)
    
    
    let storeURL = URL.document.appendingPathComponent("Payme.sqlite")
    
  //try! FileManager.default.removeItem(at: storeURL)
    let options = [NSMigratePersistentStoresAutomaticallyOption: true, NSInferMappingModelAutomaticallyOption: true]

   try!
    
    
      psc.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: options)
    
    //Create and return NSManageObjectContext
    
    let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    context.persistentStoreCoordinator = psc
    
    return context
    
    
}
extension URL {
    static var document :URL{
        return try! FileManager
        .default
        .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    }
}

protocol  ManageObjectContextDependentType {
    var managedObjectContext:NSManagedObjectContext!{get set}
}
