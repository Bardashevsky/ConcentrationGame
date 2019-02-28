//
//  HardResultUITableViewController.swift
//  ConcentrationGame
//
//  Created by Oleksandr Bardashevskyi on 2/28/19.
//  Copyright © 2019 Oleksandr Bardashevskyi. All rights reserved.
//

import UIKit

class HardResultUITableViewController: LeaderBoardParentClass {

    override func viewDidLoad() {
        super.viewDidLoad()
        for peroson in newPlayerNew {
            if peroson.difficulty?.easyMediumHard == "Hard" {
                newArray.append(peroson)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newArray.count
    }
}
