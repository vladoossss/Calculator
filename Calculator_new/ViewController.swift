//
//  ViewController.swift
//  Calculator_new
//
//  Created by user193665 on 2/21/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    
    var typing = false
    var firstOperand:Double = 0
    var secondOperand:Double = 0
    var sign:String = ""
    var dotIsPlaced = false
    var currentInput:Double {
        get{
            return Double(resultLabel.text!)!
        }
        set{
            let value = "\(newValue)"
            let valueArray = value.components(separatedBy: ".")
            if valueArray[1] == "0"{
                resultLabel.text = "\(valueArray[0])"
            }
            else{
                resultLabel.text = "\(newValue)"
            }
            
            typing = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func digits(_ sender: UIButton) {
        let number = sender.currentTitle!
        if typing{
            resultLabel.text = resultLabel.text! + number
        }
        else{
            resultLabel.text = number
            typing = true
        }
        
    }
    @IBAction func twoOperands(_ sender: UIButton) {
        sign = sender.currentTitle!
        firstOperand = currentInput
        typing = false
        dotIsPlaced = false
    }
    
    func operate(operation: (Double, Double) -> Double){
        currentInput = operation(firstOperand, secondOperand)
        typing = false
    }
    
    
    @IBAction func equal(_ sender: UIButton) {
        if typing{
            secondOperand = currentInput
        }
        
        switch sign{
        case "+":
            operate{$0 + $1}
        case "-":
            operate{$0 - $1}
        case "*":
            operate{$0 * $1}
        case "/":
            operate{$0 / $1}
        default: break
        }
        
        dotIsPlaced = false
        sign = ""
        typing = false
    }
    
    @IBAction func clearAll(_ sender: UIButton) {
        firstOperand = 0
        secondOperand = 0
        currentInput = 0
        resultLabel.text = "0"
        typing = false
        dotIsPlaced = false
        sign = ""
    }
    
    @IBAction func addMinus(_ sender: UIButton) {
        currentInput = -currentInput
    }
    
    @IBAction func percentage(_ sender: UIButton) {
        if firstOperand == 0{
            currentInput = currentInput / 100
        }
        else{
            secondOperand = firstOperand * currentInput / 100
        }
        typing = false
    }
    
    
    @IBAction func addDot(_ sender: UIButton) {
        if typing && !dotIsPlaced{
            resultLabel.text = resultLabel.text! + "."
            dotIsPlaced = true
        }
        else if !typing && !dotIsPlaced{
            resultLabel.text = "0."
            dotIsPlaced = true
            typing = true
        }
    }
    
}

