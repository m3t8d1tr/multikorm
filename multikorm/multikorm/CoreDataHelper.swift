//
//  CoreDataHelper.swift
//  multikorm
//
//  Created by Денис on 28.12.16.
//  Copyright © 2016 DenisTkachev. All rights reserved.
//


// можно брать для других проектов для записи в файл(базу) данных
import UIKit
import CoreData

class CoreDataHelper: NSObject { //три стандартных свойства класса для создания объектов для CoreData
    let model: NSManagedObjectModel
    let coordinator: NSPersistentStoreCoordinator
    let context: NSManagedObjectContext
    
    static let main = CoreDataHelper() //как только запустим приложение, то будет создан только 1 главный хелпер для работы с базой данных
    // static чтобы обращатся сразу CoreDataHelper.main
    
    override init() {
        let modelURL = Bundle.main.url(forResource: "Model", withExtension: "momd") //имя файла и его расширение
        // создаём объект на основе файла
        self.model = NSManagedObjectModel(contentsOf: modelURL!)!
        // создаём координатор на основе этой модели
        self.coordinator = NSPersistentStoreCoordinator(managedObjectModel: model)
        //путь куда класть файл. Получаем путь к папке нашего приложения
        let docsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        // myapp/Documents/store.sqlite
        let storeURL = docsURL.appendingPathComponent("store.sqlite")
        
        //обрабока ошибки
        do {
            // если файл есть то открыть, если нет, то создать
            try self.coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: nil)
        } catch let error {
            print("Не смогли открыть/создать хранилище: \(error) ")
        }
        // создаём контекст в рамках которого булем создавать объекты
        self.context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        // говорим контексту с каким координатором работать
        self.context.persistentStoreCoordinator = coordinator
    }
}

