//
//  Date.swift
//  CarInfo
//
//  Created by Максим Шалашников on 15.10.2019.
//  Copyright © 2019 Maxim Shalashnikov. All rights reserved.
//

import Foundation

extension Date {
    //return current year
    func yearAsString() -> String {
        let df = DateFormatter()
        df.setLocalizedDateFormatFromTemplate("YYYY")
        return df.string(from: self)
    }
}
