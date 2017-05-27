//
//  TextFieldProtocol.swift
//  MemeApp
//
//  Created by Raúl Feliz Alonso on 26/5/17.
//  Copyright © 2017 RukiaSoft. All rights reserved.
//

import UIKit

protocol TextFieldProtocol {
    func restoreInitialText(_ textField: UITextField, _ force: Bool)
    func isInInitialState(_ text: String) -> Bool
}
