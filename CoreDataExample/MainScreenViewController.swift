//
//  MainScreenViewController.swift
//  CoreDataExample
//
//  Created by Software Station on 5/22/19.
//  Copyright © 2019 Software Station. All rights reserved.
//

import UIKit
import CoreData

class MainScreenViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var warehouseControl: UISegmentedControl!
    var databaseManager: DataBaseManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        databaseManager = CoreDataManager()
        setupTableView()
        showAll()
    }
    
    
    var furnitureList: [Furniture] = [] {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func showChairs() {
        databaseManager.fetchChairs { [weak self] result in
            switch result {
            case .failure(let error):
                debugPrint(error)
                
            case .success(let chairs):
                self?.furnitureList = chairs
            }
        }
    }
    
    private func showTables() {
        databaseManager.fetchTables { [weak self] result in
            switch result {
            case .failure(let error):
                debugPrint(error)
                
            case .success(let tables):
                self?.furnitureList = tables
            }
        }
    }
    
    private func showAll() {
        databaseManager.fetchAllFurniture { [weak self] result in
            switch result {
            case .failure(let error):
                debugPrint(error)
                
            case .success(let furnitureList):
                self?.furnitureList = furnitureList
            }
        }
    }
    
    @IBAction private func generateFurniture() {
        var newTables: [Table] = []
        var newChairs: [Chair] = []
        for i in 0...5 {
            let randomValue = Bool.random()
            let newTable = Table(name: "Table \(i)", material: .wood)
            let newChair = Chair(name: "Chair \(i)", material: randomValue ? .cloth : .wood, isAdjustable: randomValue)
            newChairs.append(newChair)
            newTables.append(newTable)
        }
        let abstractFurniture = Furniture(name: "abstract furniture",  material: .wood)
        databaseManager.saveFurniture([abstractFurniture]) { [weak self] result in
            switch result {
            case .success:
                self?.showAll()
            case .failure(let error):
                debugPrint("savingError - \(error)")
            }
        }
        databaseManager.saveChairs(newChairs) { [weak self] result in
            switch result {
            case .success:
                self?.showAll()
            case .failure(let error):
                debugPrint("savingError - \(error)")
            }
        }

        databaseManager.saveTables(newTables) { result in
            if case .failure(let error) = result {
                debugPrint("savingError - \(error)")
            }
        }
    }
    
    @IBAction func filterOptionsPressed(_ sender: Any) {
        let alertController = UIAlertController(title: NSLocalizedString("Choose option", comment: ""),
                                                message: nil,
                                                preferredStyle: .actionSheet)
        
        let chairsOption = UIAlertAction(title: NSLocalizedString("Chairs", comment: ""), style: .default) {[weak self] (_) in
            self?.showChairs()
        }
        
        let tablesOption = UIAlertAction(title: NSLocalizedString("Tables", comment: ""), style: .default) {[weak self] (_) in
            self?.showTables()
        }
        
        let allOption = UIAlertAction(title: NSLocalizedString("All", comment: ""), style: .default) {[weak self] (_) in
            self?.showAll()
        }
        
        let cancelOption = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel, handler: nil)
        
        alertController.addAction(allOption)
        alertController.addAction(chairsOption)
        alertController.addAction(tablesOption)
        alertController.addAction(cancelOption)
        
        present(alertController,
                animated: true,
                completion: nil)
    }
    
}

extension MainScreenViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return furnitureList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "furnitureCell", for: indexPath)
        let itemForCell = furnitureList[indexPath.row]
        cell.textLabel?.text = itemForCell.name
        
        return cell
    }
    
    
}
