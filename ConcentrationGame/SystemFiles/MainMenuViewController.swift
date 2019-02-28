//
//  ViewController.swift
//  ConcentrationGame
//
//  Created by Oleksandr Bardashevskyi on 2/23/19.
//  Copyright © 2019 Oleksandr Bardashevskyi. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {
    
    enum PickerDrumSelected {
        case Easy
        case Normal
        case Hard
    }
    var selectedDrum = PickerDrumSelected.Easy
    var startGame = UIButton()
    var leaderBoardButton = UIButton()
    var pickerDrum = UIPickerView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        
        createStartButton()
        createLeaderBoardButton()
        addDrum()
    }
    
    //MARK: - Add pickerView
    func addDrum() {
        pickerDrum.center = self.view.center
        pickerDrum.dataSource = self
        pickerDrum.delegate = self
        
        self.view.addSubview(pickerDrum)
    }
    //MARK: - Create Buttons
    func createStartButton() {
        createButton(button: startGame, title: "Start Game", backgroundColor: UIColor.green, indent: 100)
        startGame.addTarget(self, action: #selector(handleStartGameButton), for: UIControl.Event.touchUpInside)
    }
    func createLeaderBoardButton() {
        createButton(button: leaderBoardButton, title: "Leaders Board", backgroundColor: UIColor.lightGray, indent: 40)
        leaderBoardButton.addTarget(self, action: #selector(handleButtonLeaderBoard), for: UIControl.Event.touchUpInside)
    }
    
    func createButton(button: UIButton, title: String, backgroundColor: UIColor, indent: Int) {
        button.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        button.setTitle(title, for: UIControl.State.normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = backgroundColor
        button.setTitleColor(#colorLiteral(red: 0.0239027201, green: 0, blue: 1, alpha: 1), for: UIControl.State.normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.layer.borderWidth = 3
        button.layer.borderColor = UIColor.orange.cgColor
        button.center = CGPoint(x: Int(self.view.bounds.midX), y: Int(self.view.bounds.maxY) - indent)
        
        
        self.view.addSubview(button)
    }
    //MARK: - Change Game Difficulty
    @objc func handleStartGameButton() {
        if selectedDrum == .Easy {
            loadGameViewCintroller(identifierVC: "easyGame")
        } else if selectedDrum == .Normal {
            loadGameViewCintroller(identifierVC: "mediumGame")
        } else if selectedDrum == .Hard {
            loadGameViewCintroller(identifierVC: "hardGame")
        }
    }
    func loadGameViewCintroller(identifierVC: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: identifierVC)
        self.present(controller, animated: true, completion: nil)
    }
    //MARK: - Leader List Button
    @objc func handleButtonLeaderBoard() {
        let vc = ResultUITabBarController()
        //vc.restorationIdentifier = "name"
        let rootVC = UINavigationController(rootViewController: vc)
        present(rootVC, animated: true, completion: nil)
    }

}
//MARK: - UIPickerViewDataSource
extension MainMenuViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 3
    }
    
    
}
//MARK: - UIPickerViewDelegate
extension MainMenuViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        switch row {
        case 0:
            selectedDrum = PickerDrumSelected.Easy
            return NSAttributedString(string: "Easy", attributes: [NSAttributedString.Key.foregroundColor: UIColor.green, .font : UIFont.boldSystemFont(ofSize: 70)])
        case 1:
            selectedDrum = PickerDrumSelected.Normal
            return NSAttributedString(string: "Medium", attributes: [NSAttributedString.Key.foregroundColor: UIColor.yellow, .font : UIFont.boldSystemFont(ofSize: 70)])
        case 2:
            selectedDrum = PickerDrumSelected.Hard
            return NSAttributedString(string: "Hard", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red, .font : UIFont.boldSystemFont(ofSize: 70)])
        default:
            return nil
        }
    }
}
