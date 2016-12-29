//
//  Category.swift
//  multikorm
//
//  Created by Денис on 28.12.16.
//  Copyright © 2016 DenisTkachev. All rights reserved.
//

// модель для сохранения категорий
import UIKit
import CoreData // хранение данных

@objc(Category) // обязательно
class Category: NSManagedObject {
    @NSManaged var id: Int16
    @NSManaged var name: String
    @NSManaged var parent_id: Int16
    //    @NSManaged var longitude: Double
    //    @NSManaged var address: String
    //    @NSManaged var transactions: NSSet
    
    
    convenience init(id: Int16, name: String, parent_id: Int16){
        
        self.init(entity: NSEntityDescription.entity(forEntityName: "Category", in: CoreDataHelper.main.context)!, insertInto: CoreDataHelper.main.context) // nil потому что мы сохраним только то что выберет пользователь. Если нам надо соранить сразу в базу всё что распарсили, то напишем context
        
        self.id = id
        self.name = name
        self.parent_id = parent_id
    }
}

