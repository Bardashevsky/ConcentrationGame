//
//  GameViewController.swift
//  ConcentrationGame
//
//  Created by Oleksandr Bardashevskyi on 2/23/19.
//  Copyright © 2019 Oleksandr Bardashevskyi. All rights reserved.
//

import UIKit
import CoreData

class EasyGameViewController: UIViewController {
    
    enum DifficultyEnum: Int {
        case Easy = 6
        case Medium = 12
        case Hard = 20
    }
    
    //MARK: - Variables
    var flipCount = 0
    var emojiChoices = [String]()
    var arrayOfSenderTags = [UIButton]()
    var enableCount = 0
    let uni = Unicodes()
    
    //MARK: - CoreData контекст для связи обьектов с БД
    var context: NSManagedObjectContext!
    
    @IBOutlet weak var flipLable: UILabel!
    @IBOutlet var buttonsOutletCollection: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //MARK: - Core Data Save
        guard let appDelegate = //используем аппделегат для получение доступа к контексту
            UIApplication.shared.delegate as? AppDelegate else {
                fatalError("appdelegate error")
        }
        context = appDelegate.persistentContainer.viewContext //Получаем контекст из PersistentContainer
        
        addAnimalsFunction()
        editStyle(ofSize: 70)
    }
    
    //MARK: - Actions
    @IBAction func menuButtonAction(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Are you sure?", message: "", preferredStyle: UIAlertController.Style.alert)
        let cancelActior = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil)
        let okAction = UIAlertAction(title: "Yes!", style: UIAlertAction.Style.default) { (action) in
            super.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(cancelActior)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    //MARK: - Main buttons function
    @IBAction func gameButtonsAction(_ sender: UIButton) {
        gameLogic(sender)
        alert(enableCountForDifficulty: DifficultyEnum.Easy.rawValue, difficulty: "Easy", selectedIndex: 0)
    }
    
    
    //MARK: Game Logic
    func gameLogic(_ sender: UIButton) {
        
        sender.isEnabled = false
        flipCount += 1
        flipLable.text = "Flips: \(flipCount)"
        if let cardNumber = buttonsOutletCollection.index(of: sender) {
            flipCard(withEmoji: emojiChoices[cardNumber], on: sender)
        }
        arrayOfSenderTags.append(sender)
        
        if arrayOfSenderTags.count == 2 {
            if arrayOfSenderTags[0].titleLabel?.text == arrayOfSenderTags[1].titleLabel?.text {
                
                arrayOfSenderTags[0].backgroundColor = #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)
                arrayOfSenderTags[1].backgroundColor = #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)
                arrayOfSenderTags[0].isEnabled = false
                arrayOfSenderTags[1].isEnabled = false
                self.arrayOfSenderTags.removeAll()
                enableCount += 1
                
            } else if arrayOfSenderTags[0].titleLabel?.text != arrayOfSenderTags[1].titleLabel?.text {
                
                arrayOfSenderTags[0].isEnabled = true
                arrayOfSenderTags[1].isEnabled = true
                
                UIApplication.shared.beginIgnoringInteractionEvents()

                UIView.animate(withDuration: 0.3, delay: 1, options: UIView.AnimationOptions.curveLinear, animations: {
                    
                    self.arrayOfSenderTags[0].backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
                    self.arrayOfSenderTags[1].backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
                    
                }) { (true) in
                    
                    self.arrayOfSenderTags[0].setTitle("", for: UIControl.State.normal)
                    self.arrayOfSenderTags[1].setTitle("", for: UIControl.State.normal)
                    UIApplication.shared.endIgnoringInteractionEvents()
                    self.arrayOfSenderTags.removeAll()
                    
                }
            }
        }
    }
    
    //MARK: - AlertAction & add CoreData
    func alert(enableCountForDifficulty: Int, difficulty: String, selectedIndex: Int) {
        if enableCount == enableCountForDifficulty {
            let alertController = UIAlertController(title: "Enter your name:", message: "", preferredStyle: UIAlertController.Style.alert)
            let actionAlert = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { (action) in
                let text = alertController.textFields?.first?.text
                //MARK: - Add data in to CoreData
                let difficulty = self.addDifficulty(difficulty: difficulty)
                self.addNewPlayer(name: (text?.isEmpty)! || text == nil ? "Player" : text!,
                                               highScore: Int16(self.flipCount),
                                               difficulty: difficulty)
                let destinationVC = ResultUITabBarController()
                destinationVC.selectedIndex = selectedIndex
                let navVC = UINavigationController(rootViewController: destinationVC)
                self.present(navVC, animated: true, completion: nil)
                
            }
            alertController.addAction(actionAlert)
            alertController.addTextField(configurationHandler: nil)
            present(alertController, animated: true, completion: nil)
        }
    }
    //MARK: - FlipeCard Logic
    func flipCard(withEmoji emoji: String, on button: UIButton) {
        if button.currentTitle != emoji {
            button.setTitle(emoji, for: UIControl.State.normal)
            button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
    }
    //MARK: - Add animals
    func addAnimalsFunction() {
        self.emojiChoices = uni.changeGame(difficulty: Unicodes.Difficulty.Easy)
    }
    //MARK: - Edit style
    func editStyle(ofSize: CGFloat) {
        
        flipLable.layer.borderColor = UIColor.orange.cgColor
        flipLable.layer.borderWidth = 1
        flipLable.layer.cornerRadius = 10
        
        for i in self.buttonsOutletCollection {
            i.layer.cornerRadius = 10
            i.titleLabel?.font = UIFont.boldSystemFont(ofSize: ofSize)
            i.titleLabel?.textAlignment = .center
        }
    }
    
    //MARK: - Add Data into CoreData
    func addDifficulty(difficulty: String) -> Difficulty {
        let dif = Difficulty(context: context)
        
        dif.easyMediumHard = difficulty
        
        do {
            try context.save()
        } catch let error as NSError {
            print("Could't save \(error)")
        }
        
        return dif
    }
    func addNewPlayer(name: String, highScore: Int16, difficulty: Difficulty) { //-> NewPlayerHighscore {
        let npHighScore = NewPlayerHighscore(context: context)
        npHighScore.name = name
        npHighScore.highscore = highScore
        npHighScore.difficulty = difficulty
        
        do {
            try context.save()
        } catch let error as NSError {
            print("Could't save \(error)")
        }
        
        //return npHighScore
    }
    
    //MARK: - Delete All Data
    func deleteAllData(_ entity:String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let results = try self.context.fetch(fetchRequest)
            for object in results {
                guard let objectData = object as? NSManagedObject else {continue}
                self.context.delete(objectData)
            }
        } catch let error {
            print("Detele all data in \(entity) error :", error)
        }
    }
}
