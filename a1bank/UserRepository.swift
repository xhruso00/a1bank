//
//  UserRepository.swift
//  a1bank
//
//  Created by Panagiotis Papastamatis on 21/03/2016.
//  Copyright © 2016 Panagiotis Papastamatis. All rights reserved.
//

import Foundation

import CoreData

import UIKit



class UserRepository {

    init()
    {

    }


    func getUser(userName: String) -> User?
    {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        var context:NSManagedObjectContext = appDelegate.managedObjectContext
        
        var request = NSFetchRequest(entityName: "Users")
        request.returnsObjectsAsFaults = false;
        request.predicate = NSPredicate(format: "username = %@", userName)
        var results: NSArray
        
        do {
            results = try context.executeFetchRequest(request)
        } catch _ {
            print("nil1")
            return nil
        }
        
        if results.count < 1
        {
            print("nil2")
            return nil
        }
        else
        {
            print(results.count)
            let r = results[0] as! NSManagedObject
            let id = r.valueForKey("id") as! Int;
            let firstName = r.valueForKey("firstName") as! String;
            let lastName = r.valueForKey("lastName") as! String;
            let userName = r.valueForKey("username") as! String;
            let password = r.valueForKey("password") as! String;
            let email = r.valueForKey("email") as! String
            let dateOfBirth = r.valueForKey("dateOfBirth") as! NSDate
            return User(id: Int32(id), userName: userName, password: password, firstName: firstName, lastName: lastName, email: email, dateOfBirth: dateOfBirth)
            
        
        }
        
    }

    func createUser(id: Int32, userName: String, password: String, firstName: String, lastName: String, dob: NSDate, email: String) -> Bool? {
        if (getUser(userName) != nil) {
            return false
        }
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context:NSManagedObjectContext = appDelegate.managedObjectContext
        
        let u = NSEntityDescription.insertNewObjectForEntityForName("Users", inManagedObjectContext: context)
        
        u.setValue(NSNumber(int: id), forKey: "id")
        u.setValue(userName, forKey: "username")
        u.setValue(password, forKey: "password")
        u.setValue(firstName, forKey: "firstName")
        u.setValue(lastName, forKey: "lastName")
        u.setValue(email, forKey: "email")
        u.setValue(dob, forKey: "dateOfBirth")
        do {
            try context.save()
        } catch _ {
            return false
        }
        
        print(u)
        
        return true
    }
    
    func deleteUser(id: Int32) -> Bool
    {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        var context:NSManagedObjectContext = appDelegate.managedObjectContext
        var request = NSFetchRequest(entityName: "Users")
        request.returnsObjectsAsFaults = false;
        request.predicate = NSPredicate(format: "id = %i", id)
        var results: NSArray
        
        do {
            results = try context.executeFetchRequest(request)
        } catch _ {
            return false
        }
        
        if results.count < 1
        {
            return false
        }
        else
        {
            print(results.count)
            let r = results[0] as! NSManagedObject
            context.deleteObject(r)
            do {
                try context.save()
                return true
            } catch _ {
                return false
            }
            
        }
    }
    

}


