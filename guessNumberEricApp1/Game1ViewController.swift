//
//  Game1ViewController.swift
//  guessNumberEricApp1
//
//  Created by user on 2020/9/1.
//  Copyright © 2020 user. All rights reserved.
//

import UIKit

class Game1ViewController: UIViewController {

    @IBOutlet weak var rangeLabel: UILabel!
    @IBOutlet weak var remainLabel: UILabel!
    @IBOutlet weak var numberTextField: UITextField!
 
    var random = 0
    var remainNumber = 6
    var maxNumber = 100
    var minNumber = 0
    
    // 下面這個 func 是提示輸入者 的 最大最小範圍值
    func rangeHint()->String{
        
        return "\(minNumber) ~ \(maxNumber)"
        
    }
    // 以下判斷 輸入數字值 之判斷
    func judgement (number : Int){
        if number > 100 {
            caveat(title: "錯誤", message: "請輸入 0 ~ 100 的整數")
        } else if number > random {
            maxNumber = number - 1
            rangeLabel.text = rangeHint()
            remainNumber -= 1
            remainLabel.text = "\(remainNumber)"
            
        }else if number < random {
            minNumber = number + 1
            rangeLabel.text = rangeHint()
            remainNumber -= 1
            remainLabel.text = "\(remainNumber)"
        }else {
            caveat(title: "太好了", message: "成功猜中數字\(random)")
        }
        
    }
    //以下 func 是 出現警告訊息的寫法
    func caveat (title : String, message : String?){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
        
    }
    // 重新開始
    func renew (){
        // 以下是 重新取得 0~100 整數的寫法
        random = Int(arc4random_uniform(100))
        maxNumber = 100
        minNumber = 0
        rangeLabel.text = rangeHint()
        remainNumber = 6
        remainLabel.text = "\(remainNumber)"
    }
    
    @IBAction func againButton(_ sender: Any) {
        
        renew()
        
    }
    
    // 按下 Guess 後的程式判斷
    @IBAction func guessButton(_ sender: Any) {
        view.endEditing(true)
        if numberTextField.text == "" {
            caveat(title: "錯誤", message: "請輸入小於100 的整數")
            // Int(numberTextField.text!) 是 文字轉型 整數的寫法
        }else if Int(numberTextField.text!) == nil {
            caveat(title: "只能輸入數字啊 ！", message: nil)
        }else if remainNumber > 0 {
            let n = Int(numberTextField.text!)
            judgement(number: n!)
        }else {
            caveat(title: "失敗了 ！", message: "正確數字是 ：\(random)")
            renew()
        }
        numberTextField.text = ""
        print("\(random)")
        
    }
      
    override func viewDidLoad() {
        super.viewDidLoad()
        // 以下是 取得 最大亂數 100 的整數寫法 ！謹記 ！
        random = Int(arc4random_uniform(100))
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
