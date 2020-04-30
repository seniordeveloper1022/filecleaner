//
//  RIATextfield.swift
//  InsafiansPTI
//
//  Created by Zaryab on 1/5/18.
//  Copyright © 2018 Ghafar Tanveer. All rights reserved.
//

import UIKit

import Foundation
import UIKit
class RIATextfield: UITextField {
    override func awakeFromNib() {
        super.awakeFromNib()
        layoutIfNeeded()
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.black.cgColor
        layoutIfNeeded()
    }
}
