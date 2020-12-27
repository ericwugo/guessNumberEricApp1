//
//  ViewController.swift
//  guessNumberEricApp1
//
//  Created by user on 2020/9/1.
//  Copyright © 2020 user. All rights reserved.
//

import UIKit
// import GamePlayKit 是為了要運用 GKShuffledDistribution 這函數
import GameplayKit

class ViewController: UIViewController {
    
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var enterTextField: UITextField!
    @IBOutlet weak var promptTextView: UITextView!
    @IBOutlet weak var recordsTextView: UITextView!
    
    @IBOutlet weak var frequencyLabel: UILabel!
    
    var randomArray = ["","","",""]
    var frequency = 0
    var record : String = ""
    var record1 : String = ""
    // 記錄使用者輸入數字 與 提醒 的判斷
    func recordAnswer(answer : String, a : Int, b:Int){
        
        record = "\(a)A\(b)B \n" + record
        record1 = "\(answer)\n" + record1
        promptTextView.text = record
        recordsTextView.text = record1
        enterTextField.text = ""
        
    }
    
    
    
    // 以下為 亂數 取四個數字 (平均機率)並放入 陣列中 的寫法 重點是 GKShuffledDistribution 的取值運用
    func topic (){
        let number = GKShuffledDistribution(lowestValue: 0, highestValue: 9)
        // 以下是用 for 迴圈 把取到的值 放入陣列 的寫法
        for i in 0...randomArray.count - 1 {
            randomArray[i] = "\(number.nextInt())"
        }
        print("\(randomArray)")
        
    }
    
    // 把四個數字 由陣列取出 , 再顯示在 Label 中的方法
    func correct (){
        answerLabel.isHidden = false
        answerLabel.text = "\(randomArray[0])"+"\(randomArray[1])"+"\(randomArray[2])"+"\(randomArray[3])"
       
    }
   
    // 警告訊息的寫法 , 很制式的運用 ！
    func cavet (title : String, message : String?){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(alertAction)
        present(alert,animated: true,completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topic()
        // Do any additional setup after loading the view.
    }

    // 以下是判斷 輸入數字 與 提示 的寫法 ！ 很厲害的邏輯思維！
    @IBAction func guessButton(_ sender: Any) {
       // if let 是 swift 為了避免 nil 值 又要給值 的寫法
        if let enter = enterTextField.text {
            
            if enter.count == 4 {
                var a = 0
                var b = 0
                var i = 0
                frequency += 1
                frequencyLabel.text = "\(frequency)"
                // 陣列值與 輸入值 的比對 全對者 a+1
                for ii in enter {
                    let number = String(ii)
                    if randomArray[i] == number {
                        a += 1
                    }
                        // 陣列值與 輸入值 的比對 包含 contain 者 b+1
                    else if randomArray.contains(number){
                        b += 1
                    }
                    i += 1
                }
                // 當 a=4 全對
                if a == 4 {
                    correct()
                    cavet(title: "答對了 ！", message: "太厲害了")
                }else{
                    // 當 a 小於 4 則跑 recordAnswer func並帶入 a, b
                    recordAnswer(answer: enter, a: a, b: b)
                }
                
            }else{
             // 如果輸入 小數 或是 文字 出現的錯誤訊息
                cavet(title: "錯誤", message: "請輸入四個不一樣的數字")
                enterTextField.text = ""
            }
            
            
            
        }
        // 將鍵盤收起來
        view.endEditing(true)
        
    }
    
    
    // 重新再玩一次 清空數值的方法
    @IBAction func againButton(_ sender: Any) {
        
        topic()
        frequency = 0
        frequencyLabel.text = "\(frequency)"
        record = ""
        record1 = ""
        promptTextView.text = ""
        recordsTextView.text = ""
        enterTextField.text = ""
        answerLabel.isHidden = true
        
        
    }
    
    
    
    
}

