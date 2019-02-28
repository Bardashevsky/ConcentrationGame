//
//  Name.swift
//  ConcentrationGame
//
//  Created by Oleksandr Bardashevskyi on 2/23/19.
//  Copyright © 2019 Oleksandr Bardashevskyi. All rights reserved.
//

import Foundation

struct List {
    static var array = [PlayerRegistration]()
}
class PlayerRegistration {
    var name = String()
    var result = Int()
    init(name: String, result: Int) {
        self.name = name
        self.result = result
    }
}
