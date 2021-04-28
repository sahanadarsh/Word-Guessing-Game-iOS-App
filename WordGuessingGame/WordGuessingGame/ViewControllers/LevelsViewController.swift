//
//  LevelsViewController.swift
//  WordGuessingGame
//
//  Created by Sahana Adarsh on 4/18/21.
//

import UIKit
import Firebase

class LevelsViewController: UIViewController {
    
    @IBOutlet var button1: UIButton!
    
    @IBOutlet var button2: UIButton!
    
    @IBOutlet var button3: UIButton!
    
    @IBOutlet var button4: UIButton!
    
    @IBOutlet var button5: UIButton!
    
    @IBOutlet var lblRounds: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bkgImg4")!)
        button1.layer.cornerRadius = 30
        button2.layer.cornerRadius = 30
        button3.layer.cornerRadius = 30
        button4.layer.cornerRadius = 30
        button5.layer.cornerRadius = 30
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if(levelName == "level0"){
            button1.isEnabled = true
        }
        if(levelName == "level1"){
            button2.isEnabled = true
        }
        if(levelName == "level2"){
            button2.isEnabled = true
            button3.isEnabled = true
        }
        if(levelName == "level3"){
            button2.isEnabled = true
            button3.isEnabled = true
            button4.isEnabled = true
        }
        if(levelName == "level4"){
            button2.isEnabled = true
            button3.isEnabled = true
            button4.isEnabled = true
            button5.isEnabled = true
        }
        if(timesAllLevelsCompleted == 0){
            lblRounds.text = ""
        }else{
            lblRounds.text = "Completed All 5 rounds \(String(timesAllLevelsCompleted)) times"
        }
    }
    
    @IBAction func level1Action(_ sender: Any) {
        self.performSegue(withIdentifier: "Level1Segue", sender: self)
    }
    
    @IBAction func level2Action(_ sender: Any) {
        self.performSegue(withIdentifier: "Level2Segue", sender: self)
    }
    
    @IBAction func level3Action(_ sender: Any) {
        self.performSegue(withIdentifier: "Level3Segue", sender: self)
    }
    
    @IBAction func level4Action(_ sender: Any) {
        self.performSegue(withIdentifier: "Level4Segue", sender: self)
    }
    
    @IBAction func level5Action(_ sender: Any) {
        self.performSegue(withIdentifier: "Level5Segue", sender: self)
    }
    
    @IBAction func logoutAction(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            KeychainService().keyChain.delete("uid")
            self.performSegue(withIdentifier: "levelsToLoginSegue", sender: self)
        } catch{
            print (error)
        }
    }
    
}
