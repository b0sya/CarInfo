//
//  CarDirectory.swift
//  CarInfo
//
//  Created by Максим Шалашников on 07.10.2019.
//  Copyright © 2019 Maxim Shalashnikov. All rights reserved.
//

import Foundation

class CarDirectory {
    
    private(set) var cars: [Car] = []
    
    init(_ cars: [Car]){
        self.cars = cars
    }
    
    func add(newCar: Car, at index: Int) {
        for car in cars {
            if car.manufacturer == newCar.manufacturer && car.model == newCar.model && car.yearOfIssue == newCar.yearOfIssue && car.body == newCar.body { //TODO: Упростить
                return
            }
        }
        cars.insert(newCar, at: index)
    }
    
    func printDirectory() {
        for (index,car) in cars.enumerated() {
            print("\(index + 1). \(car.manufacturer), \(car.model), \(String(car.yearOfIssue)), \(String(describing: car.body))")
        }
    }
    
    func remove(at index: Int){
        if index < cars.count {
            cars.remove(at: index)
        }
    }
}
