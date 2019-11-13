//
//  CoreDataHelper.swift
//  Сurrency
//
//  Created by Алексей Евменьков on 11/4/19.
//  Copyright © 2019 MyCompany. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataHelper {
    
    private init() {}
    static let coreDatHelper = CoreDataHelper()
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    func fetchValue(complition: (_ usd_byn: Double) -> Void) {
        let request: NSFetchRequest<Rate> = Rate.fetchRequest()
        let idToSearch = "usd_byn"
        request.predicate = NSPredicate(format: "id == %@", idToSearch)
        do {
            let rates = try context.fetch(request)
            if let rate = rates.first {
                return complition(rate.value)
            }
        } catch {
            print("Unresolved errror \(error), \(error.localizedDescription)")
        } 
    }
    
    func saveValue(value: Double ) {
        let request: NSFetchRequest<Rate> = Rate.fetchRequest()
        let idToSearch = "usd_byn"
        request.predicate = NSPredicate(format: "id == %@", idToSearch)
        do {
            let rates = try context.fetch(request)
            if let rate = rates.first {
                rate.value = value
                rate.lastUpdate = Date()
            }
                else {
                    let rate = NSEntityDescription.insertNewObject(forEntityName: "Rate", into: context) as! Rate
                    rate.value = value
                rate.lastUpdate = Date()
                rate.id = idToSearch
                try? context.save()
                    
                }
        } catch {
            print("Unresolved errror \(error), \(error.localizedDescription)")
        }
    }
    
    func timeCheker() {
        var lastUpdate = Date()
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        
        let request: NSFetchRequest<Rate> = Rate.fetchRequest()
        let idToSearch = "lastUpdate"
        request.predicate = NSPredicate(format: "lastUpdate == %@", idToSearch)
        do {
            let rates = try context.fetch(request)
            if let rate = rates.first  {
                if rate.lastUpdate != nil {
                    lastUpdate = rate.lastUpdate!
                    print(lastUpdate)
                }
            }
        
        } catch {
            
        }
        
        
}
}
