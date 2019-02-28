//
//  Unicodes.swift
//  ConcentrationGame
//
//  Created by Oleksandr Bardashevskyi on 2/23/19.
//  Copyright © 2019 Oleksandr Bardashevskyi. All rights reserved.
//

import UIKit

class Unicodes: NSObject {
    var unicodes = ["🐺", "🦊", "🐵", "🐸", "🙈", "🙉", "🙊", "🐯", "🦁", "🦓", "🦒", "🐴", "🐮", "🐷", "🐻", "🐼", "🐲", "🦄",  "😸", "😹", "😻", "😽", "😾", "😿", "🙀", "🐅", "🐆", "🐘", "🦏", "🐂", "🐃", "🐄", "🐎", "🦌", "🐐", "🐏", "🐑", "🐖", "🐗", "🦛", "🐪", "🐫", "🦍", "🦙", "🦘", "🐈", "🐀", "🐁", "🐇", "🐒", "🐕", "🐩", "🐨", "🐿", "🦔", "🦇", "🐍", "🦝", "🦡", "🦅", "🦉", "🦜", "🦢", "🦚", "🦆", "🐓", "🐔", "🦃", "🕊", "🐣", "🐤", "🐥", "🐦", "🐧", "🐋", "🐳", "🐬", "🦈", "🐟", "🐠", "🐡", "🐙", "🦑", "🦐", "🦀", "🐚", "🐌", "🦞", "🐢", "🦎", "🐊", "🏇", "🎠", "🐽", "🐾", "👣", "🐀", "🐃", "🐅", "🐉", "🐍", "🐎", "🐐", "🐒", "🐓", "🐖"]
    
    enum Difficulty: Int {
        case Easy = 6
        case Medium = 12
        case Hard = 20
    }
    
    func changeGame(difficulty: Difficulty) -> [String] {
        var array = [String]()
        for _ in 0..<difficulty.rawValue {
            let random = Int(arc4random()) % (unicodes.count - 1)
            array.append(unicodes.remove(at: random))
        }
        var addAnimals = array
        addAnimals += array
        var newGameArray = [String]()
        
        for _ in 0..<addAnimals.count {
            let random = Int(arc4random()) % addAnimals.count
            newGameArray.append(addAnimals.remove(at: random))
        }
        return newGameArray
    }
}
