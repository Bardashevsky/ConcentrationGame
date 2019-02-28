//
//  HardGameViewController.swift
//  ConcentrationGame
//
//  Created by Oleksandr Bardashevskyi on 2/23/19.
//  Copyright © 2019 Oleksandr Bardashevskyi. All rights reserved.
//

import UIKit

class HardGameViewController: EasyGameViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addAnimalsFunction()
        editStyle(ofSize: 50)
    }
    
    override func gameButtonsAction(_ sender: UIButton) {
        gameLogic(sender)
        alert(enableCountForDifficulty: DifficultyEnum.Hard.rawValue, difficulty: "Hard", selectedIndex: 2)
    }
    
    //MARK: - Add animals
    override func addAnimalsFunction() {
        self.emojiChoices = uni.changeGame(difficulty: Unicodes.Difficulty.Hard)
    }
}
