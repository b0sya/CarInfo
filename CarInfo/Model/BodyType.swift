//
//  BodyType.swift
//  CarInfo
//
//  Created by Максим Шалашников on 10.10.2019.
//  Copyright © 2019 Maxim Shalashnikov. All rights reserved.
//

import Foundation

enum BodyType: String, CaseIterable {
    case Sedan
    case Hatchback
    case Wagon
    case Liftback
    case Coupe
    case Convertible
    case Roadster
    case Stretch
    case Targa
    case SUV
    case Crossover
    case Pickup
    case Van
    case Minivan
    case notIndicated = "Not indicated"
    
    static var stringArray: [String] {
        var arr = [String]()
        for value in BodyType.allCases {
            arr.append(value.rawValue)
        }
        return arr
    }
}

func stringToBodyType(string: String) -> BodyType {
    switch string {
    case "Sedan":
        return .Sedan
    case "Hatchback":
        return .Hatchback
    case "Wagon":
        return .Wagon
    case "Liftback":
        return .Liftback
    case "Coupe":
        return .Coupe
    case "Convertible":
        return .Convertible
    case "Roadster":
        return .Roadster
    case "Stretch":
        return .Stretch
    case "Targa":
        return .Targa
    case "SUV":
        return .SUV
    case "Crossover":
        return .Crossover
    case "Pickup":
        return .Pickup
    case "Van":
        return .Van
    case "Minivan":
        return .Minivan
    default:
        return .notIndicated
    }
}
