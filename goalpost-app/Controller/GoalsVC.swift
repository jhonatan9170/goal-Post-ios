//
//  ViewController.swift
//  goalpost-app
//
//  Created by jhontan on 8/14/20.
//  Copyright © 2020 jhonatan. All rights reserved.
//

import UIKit
import CoreData
let appDelegate = UIApplication.shared.delegate as? AppDelegate
class GoalsVC: UIViewController,UITableViewDelegate,UITableViewDataSource{

    @IBOutlet weak var tableView: UITableView!
    
    var goals:[Goal] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate=self
        tableView.dataSource=self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchCoreDataObject()
        tableView.reloadData()
    }
    
    @IBAction func goalBtnPressed(_ sender: UIButton) {
        guard let createGoalVC = storyboard?.instantiateViewController(identifier: "CreateGoalVC")else{return}
        presentDetail(createGoalVC)
        
    }
    //tables
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1 }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "goalCell") as? GoalCell else {return UITableViewCell()}
        let goal = goals[indexPath.row]
        
        cell.cofigureCell(goal:goal)
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        //delete action
        
        let deleteAction = UITableViewRowAction(style: .destructive, title: "DELETE"){
            (rowAction,indexPath) in
            self.removeGoal(atIndexPath: indexPath)
            self.fetchCoreDataObject()
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        deleteAction.backgroundColor=#colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        
        //add action
        
        let addAction = UITableViewRowAction(style: .normal, title: "ADD 1") { (rowAction
            , indexPath) in
            self.setProgress(atIndexPath: indexPath)
            tableView.reloadRows(at: [indexPath],with: .automatic)
        }
        addAction.backgroundColor=#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        
        return [deleteAction,addAction]
    }
    //data funtions
    
    func setProgress(atIndexPath indexPath:IndexPath) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return}
        
        let chosenGoal = goals[indexPath.row]
        
        if chosenGoal.goalProgress < chosenGoal.goalCompleticionValue{
            chosenGoal.goalProgress=chosenGoal.goalProgress + 1
        }else{return}
        
        do {
            try managedContext.save()
        } catch  {
            debugPrint("Could not set Progress \(error.localizedDescription)")
        }
        
    }
    
    func fetchCoreDataObject(){
    self.fetch { (complete) in
        if complete {
            if goals.count >= 1 {
                tableView.isHidden=false
            }else{
                tableView.isHidden=true
            }
        }
    }
    }
    
    func removeGoal(atIndexPath indexPath:IndexPath){
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return}
        
        managedContext.delete(goals[indexPath.row])
        
        do {
            try managedContext.save()
        } catch  {
            debugPrint("Could not Remove \(error.localizedDescription)")
        }
    }
        
    func fetch(completion: (_ complete:Bool)->()){
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        let fetchRequest = NSFetchRequest<Goal>(entityName: "Goal")
        
        do {
            goals = try managedContext.fetch(fetchRequest)
            completion(true)
        } catch  {
            debugPrint("Could not fecht \(error.localizedDescription)")
            completion(false)}
    }
}

