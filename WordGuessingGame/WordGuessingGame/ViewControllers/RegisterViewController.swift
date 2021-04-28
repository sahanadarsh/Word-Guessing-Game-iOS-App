//
//  RegisterViewController.swift
//  WordGuessingGame
//
//  Created by Sahana Adarsh on 4/21/21.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {
    
    @IBOutlet var txtEmail: UITextField!
    
    @IBOutlet var txtPassword: UITextField!
    
    @IBOutlet var lblStatus: UILabel!
    
    var db: Firestore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bkgImg3")!)
        self.view.bringSubviewToFront(lblStatus)
        lblStatus.text = ""
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
    }
    
    @IBAction func registerAction(_ sender: Any) {
        lblStatus.text = ""
        let email = txtEmail.text!
        let password = txtPassword.text!
        
        if email == ""  {
            lblStatus.text = "Please enter Email"
            return
        }
        
        if email.isEMail == false {
            lblStatus.text = "Please enter valid Email"
            return
        }
        
        if password == "" {
            lblStatus.text = "Please enter Password"
            return
        }
        
        if password.count < 6 {
            lblStatus.text = "Password should contain atleast 6 characters"
            return
        }
        
        if email.isEMail == false {
            lblStatus.text = "Please enter valid Email"
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password, completion: { (res, error) in
            
            if error != nil {
                self.lblStatus.text = error?.localizedDescription
                return
            }
            
            guard let uid = res?.user.uid else {
                return
            }
            
            let ref = Database.database().reference()
            let usersReference = ref.child("users").child(uid)
            let values = ["email": email]
            usersReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
                
                if error != nil {
                    self.lblStatus.text = error?.localizedDescription
                    return
                }
                
                self.dismiss(animated: true, completion: nil)
            })
            let user = Auth.auth().currentUser
            let newUser = self.db.collection("UserLevelInfo").document(user!.uid)
            let userLevelInfo = UserLevelInfoModel("level0",0)
            newUser.setData([
                "level" : userLevelInfo.level,
                "round" : userLevelInfo.round,
            ])
            self.performSegue(withIdentifier: "loginSegue", sender: self)
            
        })
        
    }
    
}
