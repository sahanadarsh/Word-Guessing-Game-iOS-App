//
//  Level2TableViewCell.swift
//  WordGuessingGame
//
//  Created by Sahana Adarsh on 4/20/21.
//

import UIKit

class Level2TableViewCell: UITableViewCell {
    
    var btn1Action : (() -> ())?
    
    var btn2Action : (() -> ())?
    
    var btn3Action : (() -> ())?
    
    @IBOutlet var button1: UIButton!
    
    @IBOutlet var button2: UIButton!
    
    @IBOutlet var button3: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        button1.layer.cornerRadius = 10
        button2.layer.cornerRadius = 10
        button3.layer.cornerRadius = 10
        self.button1.addTarget(self, action: #selector(button1Action(_:)), for: .touchUpInside)
        self.button2.addTarget(self, action: #selector(button2Action(_:)), for: .touchUpInside)
        self.button3.addTarget(self, action: #selector(button3Action(_:)), for: .touchUpInside)
    }
        
    @IBAction func button1Action(_ sender: UIButton) {
        btn1Action?()
    }
    
    @IBAction func button2Action(_ sender: UIButton) {
        btn2Action?()
    }
    
    @IBAction func button3Action(_ sender: UIButton) {
        btn3Action?()
    }
    
    
}
