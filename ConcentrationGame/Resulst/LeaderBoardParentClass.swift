//
//  LeaderTableViewController.swift
//  ConcentrationGame
//
//  Created by Oleksandr Bardashevskyi on 2/23/19.
//  Copyright © 2019 Oleksandr Bardashevskyi. All rights reserved.
//

import UIKit
import CoreData

class LeaderBoardParentClass: UITableViewController {
    
    var context: NSManagedObjectContext!
    var newPlayerNew:[NewPlayerHighscore]!
    var newArray = [NewPlayerHighscore]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        getData()
        
        self.tableView.reloadData()
        
    }
    
    //MARK: - Get CoreData Data
    func getData() {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do {
            let result = try context.fetch(NewPlayerHighscore.fetchRequest())
            self.newPlayerNew = result as? [NewPlayerHighscore]
        } catch let error as NSError {
            print("Could not load data: \(error)")
        }
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newPlayerNew.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifire = "cell"
        var cell = tableView.dequeueReusableCell(withIdentifier: identifire)
        
        let sortedArray = newArray.sorted { (s1, s2) -> Bool in
            return s2.highscore > s1.highscore
        }
        let persona = sortedArray[indexPath.row]
        if cell == nil {
            cell = UITableViewCell.init(style: UITableViewCell.CellStyle.value1, reuseIdentifier: identifire)
        }
        
        let gold = UIImage(named: "gold")
        let silver = UIImage(named: "silver")
        let bronze = UIImage(named: "bronze")
        
        if indexPath.row == 0 {
            cell?.imageView?.image = gold
            cell!.textLabel?.text = "\(indexPath.row + 1).  " + String(persona.name!)
        } else if indexPath.row == 1 {
            cell?.imageView?.image = silver
            cell!.textLabel?.text = "\(indexPath.row + 1).  " + String(persona.name!)
        } else if indexPath.row == 2 {
            cell?.imageView?.image = bronze
            cell!.textLabel?.text = "\(indexPath.row + 1).  " + String(persona.name!)
        } else {
            cell!.textLabel?.text = "         \(indexPath.row + 1).  " + String(persona.name!)
        }
        
        cell?.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        cell?.textLabel?.textColor = .blue
        cell?.detailTextLabel?.text = String(persona.highscore)
        tableView.cellForRow(at: indexPath)?.backgroundColor = .black
        return cell!
    }
    //MARK: - Table view Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

