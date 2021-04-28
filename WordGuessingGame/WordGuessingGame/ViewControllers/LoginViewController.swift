//
//  ViewController.swift
//  WordGuessingGame
//
//  Created by Sahana Adarsh on 4/18/21.
//

import UIKit
import Firebase
import SwiftSpinner

class LoginViewController: UIViewController {
    
    @IBOutlet var txtEmail: UITextField!
        
    @IBOutlet var txtPassword: UITextField!
    
    @IBOutlet var lblStatus: UILabel!
    
    var db: Firestore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bkgImg2")!)
        lblStatus.text = ""
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
    }

    override func viewDidAppear(_ animated: Bool) {
        let keyChain = KeychainService().keyChain
        
        if keyChain.get("uid") != nil {
            let userID = Auth.auth().currentUser!.uid
            
            let docRef = self.db.collection("UserLevelInfo").document(userID)


            docRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    let level = document.get("level")
                    let round = document.get("round")
                    if let levelNumber = (level) {
                        levelName = levelNumber as! String
                    }
                    if let roundNumber = (round) {
                        timesAllLevelsCompleted = roundNumber as! Int
                    }
                } else {
                    print("Document does not exist")
                }
            }
            performSegue(withIdentifier: "IntsructionsSegue", sender: self)
        }
        
        txtPassword.text = ""
    }
    
    func addKeychainAfterLogin(_ uid : String ){
        let keyChain = KeychainService().keyChain
        keyChain.set(uid, forKey: "uid")
    }

    @IBAction func loginAction(_ sender: Any) {
        lblStatus.text = ""
        let email = txtEmail.text!
        let password = txtPassword.text!
        
        if email == "" || password == "" || password.count < 6 {
            lblStatus.text = "Please enter valid Email/Password"
            return
        }
        
        if email.isEMail == false {
            lblStatus.text = "Please enter valid Email"
            return
        }
        
        
        SwiftSpinner.show("Logging in...")
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            SwiftSpinner.hide()
            guard let self = self else { return }
            
            if error != nil {
                self.lblStatus.text = error?.localizedDescription
                return
            }
            
            // We are logged in at this point
            
            let uid = Auth.auth().currentUser?.uid
            
            self.addKeychainAfterLogin(uid!)
 
            let userID = Auth.auth().currentUser!.uid
            
            let docRef = self.db.collection("UserLevelInfo").document(userID)


            docRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    let level = document.get("level")
                    let round = document.get("round")
                    if let levelNumber = (level) {
                        levelName = levelNumber as! String
                    }
                    if let roundNumber = (round) {
                        timesAllLevelsCompleted = roundNumber as! Int
                    }
                } else {
                    print("Document does not exist")
                }
            }
            self.performSegue(withIdentifier: "IntsructionsSegue", sender: self)
            
        }
            
        
    }
    
    @IBAction func registerAction(_ sender: Any) {
        self.performSegue(withIdentifier: "registerSegue", sender: self)
    }
    
   
}


