//
//  GoalCell.swift
//  goalpost-app
//
//  Created by jhontan on 8/14/20.
//  Copyright © 2020 jhonatan. All rights reserved.
//

import UIKit

class GoalCell: UITableViewCell {

    @IBOutlet weak var goalDescriptionLbl: UILabel!
    @IBOutlet weak var goalTypeLabel: UILabel!
    @IBOutlet weak var goalProgressLbl: UILabel!
    @IBOutlet weak var completionViev: UIView!
    
    func cofigureCell(goal:Goal){
        self.goalTypeLabel.text=goal.goalType
        self.goalProgressLbl.text=String(describing: goal.goalProgress)
        self.goalDescriptionLbl.text=goal.goalDescription
     if goal.goalProgress==goal.goalCompleticionValue {
        completionViev.isHidden=false
        } else {
        completionViev.isHidden=true
        }
    
    }

}
