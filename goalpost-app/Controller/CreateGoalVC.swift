//
//  CreateGoalVC.swift
//  goalpost-app
//
//  Created by jhontan on 8/15/20.
//  Copyright © 2020 jhonatan. All rights reserved.
//

import UIKit

class CreateGoalVC: UIViewController ,UITextViewDelegate{
  @IBOutlet weak var goalCreateTxtView: UITextView!
    @IBOutlet weak var nxtBtn: UIButton!
    @IBOutlet weak var longTermBtn: UIButton!
    @IBOutlet weak var shortTermBtn: UIButton!
    
    var goalType:Goaltype = .shortTerm
    override func viewDidLoad() {
        super.viewDidLoad()
        nxtBtn.bindToKeyboard()
        shortTermBtn.setSelectedColor()
        longTermBtn.setDeselectedColor()
        goalCreateTxtView.delegate=self
        
    }
    
    @IBAction func shortTermBtnPressed(_ sender: Any) {
        goalType = .shortTerm
        shortTermBtn.setSelectedColor()
        longTermBtn.setDeselectedColor()
    }
    
    @IBAction func longTermBtnPressed(_ sender: Any) {
        goalType = .longTerm
        longTermBtn.setSelectedColor()
        shortTermBtn.setDeselectedColor()
        
    }
    @IBAction func nxtBtnPressed(_ sender: Any) {
        if goalCreateTxtView.text != "" && goalCreateTxtView.text != "What is your goal ?"{
            guard let finalGoalVC = storyboard?.instantiateViewController(identifier: "FinalGoalVC") as? FinalGoalVC else {return}
            finalGoalVC.initData(description: goalCreateTxtView.text!, type: goalType)
            presentingViewController?.presentSecondaryDetail(finalGoalVC)
        }
        
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        dismissDetail()
    }

    func textViewDidBeginEditing(_ textView: UITextView) {
        goalCreateTxtView.text=""
        goalCreateTxtView.textColor=#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
}
