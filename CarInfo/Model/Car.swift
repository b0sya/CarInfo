//
//  Car.swift
//  CarInfo
//
//  Created by Максим Шалашников on 07.10.2019.
//  Copyright © 2019 Maxim Shalashnikov. All rights reserved.
//

import Foundation

struct Car {
    let uuid: String
    let yearOfIssue: String
    let brand: String
    let model: String
    let body: BodyType
    
    init(uuid: String = UUID().uuidString, year: String, brand: String, model: String, body: BodyType) {
        self.uuid = uuid
        self.yearOfIssue = year
        self.brand = brand
        self.model = model
        self.body = body
    }
}
