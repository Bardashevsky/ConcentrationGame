//
//  MediumGameViewController.swift
//  ConcentrationGame
//
//  Created by Oleksandr Bardashevskyi on 2/23/19.
//  Copyright © 2019 Oleksandr Bardashevskyi. All rights reserved.
//

import UIKit

class MediumGameViewController: EasyGameViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addAnimalsFunction()
        editStyle(ofSize: 50)
    }
    
    override func gameButtonsAction(_ sender: UIButton) {
        gameLogic(sender)
        alert(enableCountForDifficulty: DifficultyEnum.Medium.rawValue, difficulty: "Medium", selectedIndex: 1)
    }
    
    //MARK: - Add animals
    override func addAnimalsFunction() {
        self.emojiChoices = uni.changeGame(difficulty: Unicodes.Difficulty.Medium)
    }
}
