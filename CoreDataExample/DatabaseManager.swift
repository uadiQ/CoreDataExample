//
//  DatabaseManager.swift
//  CoreDataExample
//
//  Created by Software Station on 5/22/19.
//  Copyright © 2019 Software Station. All rights reserved.
//



import UIKit
import CoreData

struct NoDataError: Error {
    var localizedDescription: String = NSLocalizedString("No records found in database", comment: "")
}

struct EmptyResponse: Error {
    var localizedDescription: String = NSLocalizedString("Empty array returned", comment: "")
}

protocol DataBaseManager {
    func saveChairs(_ chairs: [Chair], completion: @escaping (Result<Bool, Error>) -> Void)
    func saveTables(_ tables: [Table], completion: @escaping (Result<Bool, Error>) -> Void)
    func saveFurniture(_ furniture: [Furniture], completion: @escaping (Result<Bool, Error>) -> Void)
    func fetchAllFurniture(completion: @escaping (Result<[Furniture], Error>) -> Void)
    func fetchTables(completion: @escaping (Result<[Table], Error>) -> Void)
    func fetchChairs(completion: @escaping (Result<[Chair], Error>) -> Void)
}

class CoreDataManager: DataBaseManager {
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "CoreDataExample")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    
    func saveChairs(_ chairs: [Chair], completion: @escaping (Result<Bool, Error>) -> Void) {
        persistentContainer.performBackgroundTask { bgContext in
            var chairsMO: [ChairMO] = []
            for chair in chairs {
                let newChairMO = ChairMO(context: bgContext)
                newChairMO.setup(from: chair)
                chairsMO.append(newChairMO)
            }
            do {
                try bgContext.save()
                completion(.success( true ))
            } catch let error {
                completion(.failure(error))
                debugPrint("Error at DB saving - \(error)")
            }
        }
    }
    
    func saveTables(_ tables: [Table], completion: @escaping (Result<Bool, Error>) -> Void) {
        persistentContainer.performBackgroundTask { bgContext in
            var tablesMO: [TableMO] = []
            for table in tables {
                let newTableMO = TableMO(context: bgContext)
                newTableMO.setup(from: table)
                tablesMO.append(newTableMO)
            }
            do {
                try bgContext.save()
                completion(.success( true ))
            } catch let error {
                completion(.failure(error))
                debugPrint("Error at DB saving - \(error)")
            }
        }
    }
    
    func saveFurniture(_ furniture: [Furniture], completion: @escaping (Result<Bool, Error>) -> Void) {
        persistentContainer.performBackgroundTask { bgContext in
            var furnituresMO: [FurnitureMO] = []
            for fur in furniture {
                let newFurnitureMO = FurnitureMO(context: bgContext)
                newFurnitureMO.setup(from: fur)
                furnituresMO.append(newFurnitureMO)
            }
            do {
                try bgContext.save()
                completion(.success( true ))
            } catch let error {
                completion(.failure(error))
                debugPrint("Error at DB saving - \(error)")
            }
        }
    }
    
    func fetchAllFurniture(completion: @escaping (Result<[Furniture], Error>) -> Void) {
        persistentContainer.performBackgroundTask { bgContext in
            let request: NSFetchRequest = FurnitureMO.fetchRequest()
            do {
                let fetchedResult = try bgContext.fetch(request)
                let result = fetchedResult.map {
                    $0.convertedPlainObject()
                }
                completion(.success(result))
            } catch let error {
                completion(.failure(error))
            }
        }
    }
    
    func fetchTables(completion: @escaping (Result<[Table], Error>) -> Void) {
        persistentContainer.performBackgroundTask { bgContext in
            let request: NSFetchRequest = TableMO.fetchRequest()
            do {
                let fetchedResult = try bgContext.fetch(request)
                let result = fetchedResult.map {
                    $0.convertedPlainObject()
                }
                completion(.success(result))
            } catch let error {
                completion(.failure(error))
            }
        }
    }
    
    func fetchChairs(completion: @escaping (Result<[Chair], Error>) -> Void) {
        persistentContainer.performBackgroundTask { bgContext in
            let request: NSFetchRequest = ChairMO.fetchRequest()
            do {
                let fetchedResult = try bgContext.fetch(request)
                let result = fetchedResult.map {
                    $0.convertedPlainObject()
                }
                completion(.success(result))
            } catch let error {
                completion(.failure(error))
            }
        }
    }
    
}
