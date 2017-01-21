//
//  data.swift
//  Bodybuilder
//
//  Created by Mateusz Oracz on 21.01.2017.
//  Copyright © 2017 BatoregoTeam. All rights reserved.
//

import Foundation
import UIKit
import CoreData

func getContext () -> NSManagedObjectContext {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    return appDelegate.persistentContainer.viewContext
}

func initialStoreIntegerValue (value: Int, recordName: String) {
    let context = getContext()
    let entity =  NSEntityDescription.entity(forEntityName: "Player", in: context)
    let transc = NSManagedObject(entity: entity!, insertInto: context)
    transc.setValue(value, forKey: recordName)
    do {
        try context.save()
    } catch let error as NSError  {
        print("Could not save \(error), \(error.userInfo)")
    } catch {
        
    }
}

func initialStoreStringValue (value: String, recordName: String) {
    let context = getContext()
    let entity =  NSEntityDescription.entity(forEntityName: "Player", in: context)
    let transc = NSManagedObject(entity: entity!, insertInto: context)
    transc.setValue(value, forKey: recordName)
    do {
        try context.save()
    } catch let error as NSError  {
        print("Could not save \(error), \(error.userInfo)")
    } catch {
        
    }
}

func initialStoreFloatValue (value: Float, recordName: String) {
    let context = getContext()
    let entity =  NSEntityDescription.entity(forEntityName: "Player", in: context)
    let transc = NSManagedObject(entity: entity!, insertInto: context)
    transc.setValue(value, forKey: recordName)
    do {
        try context.save()
    } catch let error as NSError  {
        print("Could not save \(error), \(error.userInfo)")
    } catch {
        
    }
}

func getIntRecord (recordName: String) -> Int {
    let fetchRequest: NSFetchRequest<Player> = Player.fetchRequest()
    
    do {
        let searchResults = try getContext().fetch(fetchRequest)
        print(searchResults.count)
        if(searchResults.count > 0) {
            return searchResults.first?.value(forKey: recordName) as! Int
        }
    } catch {
    }
    return 0
}

func getFloatRecord (recordName: String) -> Float {
    let fetchRequest: NSFetchRequest<Player> = Player.fetchRequest()
    
    do {
        let searchResults = try getContext().fetch(fetchRequest)
        if(searchResults.count > 0) {
            return searchResults.first?.value(forKey: recordName) as! Float
        }
    } catch {
    }
    return 0.00
}

func getStringRecord (recordName: String) -> String {
    let fetchRequest: NSFetchRequest<Player> = Player.fetchRequest()
    
    do {
        let searchResults = try getContext().fetch(fetchRequest)
        if(searchResults.count > 0) {
            return searchResults.first?.value(forKey: recordName) as! String
        }
    } catch {
    }
    return ""
}

func updateSingleIntegerRecord(value: Int, recordName: String) {
    let fetchRequest: NSFetchRequest<Player> = Player.fetchRequest()
    
    do {
        if(try getContext().fetch(fetchRequest).count == 0){
            initialStoreIntegerValue(value: value, recordName: recordName)
        }
        let searchResult = try getContext().fetch(fetchRequest).first
        searchResult?.setValue(value, forKey: recordName)
        try searchResult?.managedObjectContext?.save()
    } catch {
        
    }
}

func updateSingleFloatRecord(value: Float, recordName: String) {
    let fetchRequest: NSFetchRequest<Player> = Player.fetchRequest()
    
    do {
        if(try getContext().fetch(fetchRequest).count == 0){
            initialStoreFloatValue(value: value, recordName: recordName)
        }
        let searchResult = try getContext().fetch(fetchRequest).first
        searchResult?.setValue(value, forKey: recordName)
        try searchResult?.managedObjectContext?.save()
    } catch {
        
    }
}

func updateSingleStringRecord(value: String, recordName: String) {
    let fetchRequest: NSFetchRequest<Player> = Player.fetchRequest()
    
    do {
        if(try getContext().fetch(fetchRequest).count == 0){
            initialStoreStringValue(value: value, recordName: recordName)
        }
        let searchResult = try getContext().fetch(fetchRequest).first
        searchResult?.setValue(value, forKey: recordName)
        try searchResult?.managedObjectContext?.save()
    } catch {
        
    }
}
