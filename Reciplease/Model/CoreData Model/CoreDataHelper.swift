//
//  CoreDataHelper.swift
//  Reciplease
//
//  Created by mickael ruzel on 12/10/2020.
//

import Foundation
import CoreData

final class CoreDataHelper {
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext = AppDelegate().persistentContainer.viewContext) {
        self.context = context
    }
    
    
}
