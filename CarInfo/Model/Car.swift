//
//  Car.swift
//  CarInfo
//
//  Created by Максим Шалашников on 07.10.2019.
//  Copyright © 2019 Maxim Shalashnikov. All rights reserved.
//

import Foundation

enum BodyType {
    case Sedan, Hatchback, Wagon, Liftback, Coupe, Convertible, Roadster, Stretch, Targa, SUV, Crossover, Pickup, Van, Minivan
}

struct Car {
    let yearOfIssue: Int
    let manufacturer: String
    let model: String
    let body: BodyType
}
