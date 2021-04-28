//
//  Utilities.swift
//  WordGuessingGame
//
//  Created by Sahana Adarsh on 4/18/21.
//

import Foundation

extension String{
    
    var isEMail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
}

var levelName = ""
var timesAllLevelsCompleted = 0
