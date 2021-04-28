//
//  KeychainService.swift
//  WordGuessingGame
//
//  Created by Sahana Adarsh on 4/18/21.
//

import Foundation
import KeychainSwift

class KeychainService{
    
    var _localVar = KeychainSwift()
    
    var keyChain : KeychainSwift{
        get {
            return _localVar
        }
        set {
            _localVar = newValue
        }
    }
    
}
