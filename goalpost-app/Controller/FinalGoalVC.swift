//
//  FinalGoalVC.swift
//  goalpost-app
//
//  Created by jhontan on 8/20/20.
//  Copyright © 2020 jhonatan. All rights reserved.
//

import UIKit

class FinalGoalVC: UIViewController ,UITextFieldDelegate{
    @IBOutlet weak var createGoalBtn: UIButton!
    @IBOutlet weak var pointsTxtField: UITextField!
    
    var goalDescription:String!
    var goalType:Goaltype!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createGoalBtn.bindToKeyboard()
        pointsTxtField.delegate=self
        
    }
    
    func initData(description:String,type:Goaltype) {
        goalDescription=description
        goalType=type
    }
    
    
    @IBAction func createGoalBtnPressed(_ sender: UIButton) {
        if pointsTxtField.text != "" {
            save(completion: {(complete) in
                if complete {
                    dismiss(animated: true, completion: nil)
                }
            })
        }
        
    }
    @IBAction func backBtnPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func save(completion: (_ fisnish:Bool)->()){
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        let goal = Goal(context: managedContext)
        goal.goalDescription=goalDescription!
        goal.goalType=goalType.rawValue
        goal.goalCompleticionValue=Int16(pointsTxtField.text!)!
        goal.goalProgress=Int16(0)
        
        do {
            try managedContext.save()
            completion(true)
        } catch  {
            debugPrint("Could not save \(error.localizedDescription)")
            completion(false)
        }
        
    }
}


