//
//  CoreDataManager.swift
//  Metronome
//
//  Created by User on 18.10.2021.
//

import UIKit
import CoreData

class CoreDataManager {
    
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    func saveData(photo: Data){
        DispatchQueue.main.async {
            let save = AvatarImageCD(context: self.context)
            save.imageData = photo
            self.appDelegate.saveContext()
        }
    }
    
    func getData(complession: @escaping(Data)->(), errorData: @escaping()->()) {
        var photo = Data()
        do{
            let photoArray = try context.fetch(AvatarImageCD.fetchRequest())
            for item in photoArray {
                photo = item.imageData!
                complession(photo)
            }
        } catch {
            errorData()
            print(error.localizedDescription)
        }
    }
    
    func deleteAllData() {
        do
        {
            let results = try context.fetch(AvatarImageCD.fetchRequest())
            for managedObject in results
            {
                let managedObjectData:NSManagedObject = managedObject as NSManagedObject
                context.delete(managedObjectData)
            }
        } catch let error as NSError {
        }
    }
    
}
