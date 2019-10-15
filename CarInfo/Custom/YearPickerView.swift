//
//  YearPickerView.swift
//  CarInfo
//
//  Created by Максим Шалашников on 09.10.2019.
//  Copyright © 2019 Maxim Shalashnikov. All rights reserved.
//
// Class for a PickerView to select a date on the editing screen

import UIKit

class YearPickerView: UIPickerView {
    var years = [String]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        if let date = Int(Date().yearAsString()){
            for i in 1899..<date{
                years.insert(String(i + 1), at: 0)
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
