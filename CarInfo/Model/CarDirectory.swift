//
//  CarDirectory.swift
//  CarInfo
//
//  Created by Максим Шалашников on 07.10.2019.
//  Copyright © 2019 Maxim Shalashnikov. All rights reserved.
//

import Foundation
import CoreData

class CarDirectory {
    
    //MARK: - Properties
    var context: NSManagedObjectContext!
    private(set) var cars: [ManagedCar] = []
    private let entityName = "ManagedCar"
    
    
    init(context: NSManagedObjectContext){
        self.context = context
        
        getDataFromFile()
        
        //Load data from CoreData
        let fetchRequest: NSFetchRequest<ManagedCar> = ManagedCar.fetchRequest()
        do{
            let arr = try context.fetch(fetchRequest)
            self.cars = arr.reversed()
        }catch let error as NSError{
            print("Error: \(error), description: \(error.userInfo)")
        }
        
    }
    
    //MARK: - Methods
    func add( _ newCar: Car, at index: Int) { //TODO: - если не реализую перемещение то удалить индекс
        
        for (index, car) in cars.enumerated() {
            if car.uuid == newCar.uuid {
                cars[index].body = newCar.body.rawValue
                cars[index].model = newCar.model
                cars[index].brand = newCar.brand
                cars[index].yearOfIssue = newCar.yearOfIssue
                cars[index].uuid = newCar.uuid
                
                saveToDataBase()
                return
            }
        }
        
        let managedCarObject = ManagedCar(context: context)
        managedCarObject.body = newCar.body.rawValue
        managedCarObject.model = newCar.model
        managedCarObject.brand = newCar.brand
        managedCarObject.yearOfIssue = newCar.yearOfIssue
        managedCarObject.uuid = newCar.uuid
        
        cars.insert(managedCarObject, at: index)
        saveToDataBase()

    }
    
    func saveToDataBase(){
        do{
            try context.save()
            print("Changes saved!")
        } catch let error as NSError{
            print("Error: \(error). Description: \(error.userInfo)")
        }
    }
    
    private func getDataFromFile() {
        
        let fetchRequest: NSFetchRequest<ManagedCar> = ManagedCar.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "uuid != nil")
        
        var numOfElements = 0
        
        do{
            let count = try context.count(for: fetchRequest)
            numOfElements = count
        }catch let error as NSError{
            print("Error: \(error), description: \(error.userInfo)")
        }
        
        //If Database is empty
        guard numOfElements == 0 else { return }
        
        //Then load data from initialdata.plist
        guard let pathToFile = Bundle.main.path(forResource: "initialData", ofType: "plist") else { return }
        
        guard let dataArray = NSArray(contentsOfFile: pathToFile) else { return }
        for dictionary in dataArray {
            let car = ManagedCar(context: context)
            
            let carDictionary = dictionary as! NSDictionary
            
            car.brand = carDictionary["brand"] as? String
            car.model = carDictionary["model"] as? String
            car.yearOfIssue = carDictionary["yearOfIssue"] as? String
            car.body = carDictionary["body"] as? String
            car.uuid = UUID().uuidString
        }
        
    }
    
    func remove(at index: Int){
        
        if index < cars.count {
            let car = cars[index]
            context.delete(car)
            cars.remove(at: index)
            print("Car removed")
        }
        saveToDataBase()
    }
}
