//
//  InformationViewController.swift
//  WordGuessingGame
//
//  Created by Sahana Adarsh on 4/18/21.
//

import UIKit
import Firebase
import SwiftSpinner

class InformationViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bkgImg1")!)
    }
    
    @IBAction func logoutAction(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            KeychainService().keyChain.delete("uid")
            self.navigationController?.popViewController(animated: true)
        } catch{
            print (error)
        }
    }
    
    
    @IBAction func nextAction(_ sender: Any) {
        self.performSegue(withIdentifier: "LevelsSegue", sender: self)
    }
    
}

