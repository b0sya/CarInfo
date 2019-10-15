//
//  CarDirectoryTableViewCell.swift
//  CarInfo
//
//  Created by Максим Шалашников on 07.10.2019.
//  Copyright © 2019 Maxim Shalashnikov. All rights reserved.
//

import UIKit

class CarDirectoryTableViewCell: UITableViewCell {
    
    //MARK: - IBOutlets
    @IBOutlet weak var brand: UILabel!
    @IBOutlet weak var model: UILabel!
    @IBOutlet weak var body: UILabel!
    @IBOutlet weak var yearOfIssue: UILabel!

    //MARK: - Methods
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
