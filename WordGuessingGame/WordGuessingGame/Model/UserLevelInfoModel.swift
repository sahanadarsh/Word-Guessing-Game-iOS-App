//
//  UserLevelInfoModel.swift
//  WordGuessingGame
//
//  Created by Sahana Adarsh on 4/22/21.
//

import Foundation

class UserLevelInfoModel{
    
    var level: String = ""
    var round: Int = 0
    
    init(_ level: String, _ round: Int) {
        self.level = level
        self.round = round
    }
    
}
