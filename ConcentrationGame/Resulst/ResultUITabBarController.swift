//
//  ResultUITabBarController.swift
//  ConcentrationGame
//
//  Created by Oleksandr Bardashevskyi on 2/28/19.
//  Copyright © 2019 Oleksandr Bardashevskyi. All rights reserved.
//

import UIKit

class ResultUITabBarController: UITabBarController {
    
    var isMainVCLoad = false
    
    func initWithDismis(mainVC: Bool) -> ResultUITabBarController {
        isMainVCLoad = mainVC
        return self
    }
    
    var firstTableViewController: EasyResultUITableViewController?
    var secondTableViewController: MediumResultUITableViewController?
    var thirdTableViewController: HardResultUITableViewController?
    var arrayOfTableView: [UITableViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(backToMainMenu))
        
        firstTableViewController = EasyResultUITableViewController()
        secondTableViewController = MediumResultUITableViewController()
        thirdTableViewController = HardResultUITableViewController()
        arrayOfTableView.append(firstTableViewController!)
        arrayOfTableView.append(secondTableViewController!)
        arrayOfTableView.append(thirdTableViewController!)
        
        title = "Leaders:"
        
        let imageMedalWhite = UIImage(named: "medalWhite")
        let imageCupWhite = UIImage(named: "trophyWhite")
        let imageCrownWhite = UIImage(named: "crownWhite")
        
        let imageMedalBlack = UIImage(named: "medalBlack")
        let imageCupBlack = UIImage(named: "trophyBlack")
        let imageCrownBlack = UIImage(named: "crownBlack")
        
        firstTableViewController?.tabBarItem = UITabBarItem(title: "Easy", image: imageMedalWhite, selectedImage: imageMedalBlack)
        firstTableViewController?.tabBarItem.tag = 0
        secondTableViewController?.tabBarItem = UITabBarItem(title: "Medium", image: imageCupWhite, selectedImage: imageCupBlack)
        secondTableViewController?.tabBarItem.tag = 1
        thirdTableViewController?.tabBarItem = UITabBarItem(title: "Hard", image: imageCrownWhite, selectedImage: imageCrownBlack)
        thirdTableViewController?.tabBarItem.tag = 2
        
        self.setViewControllers(arrayOfTableView, animated: true)
        self.selectedIndex = 0
        self.selectedViewController = firstTableViewController
    }
    deinit {
        print("Controller has been deallocated")
    }
    @objc func backToMainMenu() {
        
        if isMainVCLoad == true {
            dismiss(animated: true, completion: nil)
        } else {
            present(MainMenuViewController(), animated: true, completion: nil)
        }
        
    }
    
}
