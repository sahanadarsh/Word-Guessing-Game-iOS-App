//
//  Level2ViewController.swift
//  WordGuessingGame
//
//  Created by Sahana Adarsh on 4/19/21.
//

import UIKit
import CoreLocation
import UIKit
import Alamofire
import SwiftyJSON
import SwiftSpinner
import PromiseKit
import Firebase

class Level2ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var wordsArr: [String] = [String]()
    
    var secretWord = ""
    
    var limitCount = 7
    
    var db: Firestore!
    
    @IBOutlet var level2TblView: UITableView!
    
    @IBOutlet var lblLimit: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bkgImg3")!)
        let tempImageView = UIImageView(image: UIImage(named: "bkgImg3"))
        tempImageView.frame = self.level2TblView.frame
        self.level2TblView.backgroundView = tempImageView;
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
        initializeText()
        level2TblView.delegate = self
        level2TblView.dataSource = self
        getWords()
    }
    
    
    @IBAction func logoutAction(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            KeychainService().keyChain.delete("uid")
            self.performSegue(withIdentifier: "level2ToLoginSegue", sender: self)
        } catch{
            print (error)
        }
    }
    
    func initializeText(){
        lblLimit.text = "You have \(limitCount) Limits to guess"
    }
    
    func getWords(){
        let url = getLevel2URL()
        getLevel2Words(url)
            .done { (words) in
                self.wordsArr = [String]()
                for word in words {
                    if(!word.contains("-") && !word.contains(" ") && word.count == 4){
                        self.wordsArr.append(word)
                    }
                }
                self.level2TblView.reloadData()
                let randomIndex = Int(arc4random_uniform(UInt32(12)))
                self.secretWord = self.wordsArr[randomIndex]
                print(self.secretWord)
            }
            .catch { (error) in
                print("Error in getting all the words \(error)")
            }
    }
    
    func commonCharacterCount(s1: String, s2: String) -> Int
    {
        let s1 = s1.lowercased()
        let s2 = s2.lowercased()
        var arr1 = [Int](repeating: 0, count: 26)
        var count = 0
        for ch in s1{
            arr1[Int(ch.unicodeScalars.first!.value - Unicode.Scalar("a").value)] += 1
        }
        for ch in s2{
            if ((arr1[Int(ch.unicodeScalars.first!.value - Unicode.Scalar("a").value)]) != 0){
                arr1[Int(ch.unicodeScalars.first!.value - Unicode.Scalar("a").value)] -= 1
                count += 1
            }
        }
        return count
    }
    
    func isTwoWordsSame(s1: String, s2: String) -> Bool {
        let isEqual = (s1 == s2)
        return isEqual
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = Bundle.main.loadNibNamed("Level2TableViewCell", owner: self, options: nil)?.first as! Level2TableViewCell
        if wordsArr.indices.contains(indexPath.row) {
            cell.button1.setTitle(wordsArr[indexPath.row], for: .normal)
            cell.button2.setTitle(wordsArr[indexPath.row+4], for: .normal)
            cell.button3.setTitle(wordsArr[indexPath.row+8], for: .normal)
        }
        
        cell.btn1Action = { [unowned self] in
            let word = cell.button1.titleLabel!.text
            self.limitCount -= 1
            initializeText()
            eachButtonAlert(word: word!)
        }
        
        cell.btn2Action = { [unowned self] in
            let word = cell.button2.titleLabel!.text
            self.limitCount -= 1
            initializeText()
            eachButtonAlert(word: word!)
        }
        
        cell.btn3Action = { [unowned self] in
            let word = cell.button3.titleLabel!.text
            self.limitCount -= 1
            initializeText()
            eachButtonAlert(word: word!)
        }
        
        var imageView  = UIImageView(frame:CGRect(x: 0, y: 0, width: 100, height: 200))
        let image = UIImage(named: "bkgImg3")
        cell.backgroundColor = UIColor.clear
        imageView = UIImageView(image:image)
        cell.backgroundView = imageView
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func getLevel2URL() -> String{
        var url = level2URL
        url.append(apiKey)
        return url
    }
    
    func getLevel2Words(_ url : String) -> Promise<[String]>{
        return Promise<[String]> { seal -> Void in
            AF.request(url).responseJSON { response in
                if response.error != nil {
                    seal.reject(response.error!)
                }
                var arr  = [String]()
                let words : JSON = JSON(response.data as Any)
                let wordsList = words["rhymes"]["all"].arrayValue
                for word in wordsList{
                    arr.append(word.stringValue)
                }
                seal.fulfill( arr )
            }
        }
    }
    
    func eachButtonAlert(word: String) -> (){
        if(isTwoWordsSame(s1: self.secretWord, s2: word) && self.limitCount > 0){
            lblLimit.text = ""
            let alert = UIAlertController(title: "Congragulations!!!", message: "You won the 2nd level", preferredStyle: .alert)
            levelName = "level2"
            self.limitCount = 7
            let userID = Auth.auth().currentUser!.uid
            self.db.collection("UserLevelInfo").document(userID).updateData(["level" : levelName])
            let nextLevel = UIAlertAction(title: "NEXT LEVEL", style: .default) { (alertAction) in
                self.initializeText()
                self.performSegue(withIdentifier: "Level2to3Segue", sender: self)
            }
            alert.addAction(nextLevel)
            self.present(alert, animated: true, completion: nil)
        }else if(self.limitCount > 0 && !isTwoWordsSame(s1: self.secretWord, s2: word)){
            let count = commonCharacterCount(s1: self.secretWord, s2: word)
            let alert = UIAlertController(title: "", message: "\(count) matches", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }else if(self.limitCount == 0 && !isTwoWordsSame(s1: self.secretWord, s2: word)){
            let alert = UIAlertController(title: "", message: "0 Limits :(", preferredStyle: .alert)
            let playAgainAction = UIAlertAction(title: "Play Again", style: .default) { (alertAction) in
                self.getWords()
                self.limitCount = 7
                self.initializeText()
            }
            alert.addAction(playAgainAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}
