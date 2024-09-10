//
//  ViewController.swift
//  calculatorApp
//
//  Created by Mac on 28/07/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var displayLabel: UILabel!
    
    var currentInput : String = ""
    var previousInput : String? = ""
    var currentOperation : Operation?
    var currentNumber : Int?
    var previousNumber : Int?
    
    enum Operation{
        case add,substract,multiplication,division
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayScreen()
        configureButtons(in: self.view)
        configureLabel(in: self.view)
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor.black.cgColor
        
    }
    
    
    func configureLabel(in view: UIView){
        displayLabel.layer.cornerRadius = 0.0
        displayLabel.layer.borderWidth = 1.0
        displayLabel.layer.borderColor = UIColor.black.cgColor
    }

    
    @IBAction func digitPressed(_ sender: UIButton) {
        
        if currentInput == ""{
            currentInput = "0"
        }
        currentInput += String(sender.tag)
        displayScreen()
        
    }
    
  
    @IBAction func operatorPressed(_ sender: UIButton) {
        let operation = sender.tag
        
        switch operation {
        case 10: currentOperation = .add
        case 11: currentOperation = .substract
        case 12: currentOperation = .multiplication
        case 13: currentOperation = .division
        default: print("wrong happened at operatorPressed.")
        }
        previousInput = currentInput
        currentInput = ""
    }
    
    @IBAction func equalsPressed(_ sender: UIButton) {
        var result : Int?
        if currentInput == ""{
            currentInput = "0"
        }
        guard let CurrentOperation = currentOperation,
              let previousNumber = Int(previousInput!),
              let currentNumber = Int(currentInput) else {
                    return
                }
        
        
        switch CurrentOperation {
        case .add: result = previousNumber + currentNumber
        case .substract: result = previousNumber - currentNumber
        case .multiplication: result = previousNumber * currentNumber
        case .division:
            if previousNumber != 0 && currentNumber != 0{
                result = previousNumber / currentNumber
            }else{
                displayLabel.text = "Error"
                    return
            }
        default:
            print("something got wrong in equalspressed.")
        }
        
        currentInput = String(result!)
        displayScreen()
        currentOperation = nil
        
        
    }
    
    
    @IBAction func clearPressed(_ sender: UIButton) {
        currentInput = ""
        previousInput = ""
        currentOperation = nil
        displayLabel.text = "0"
        
    }
    
    
    func displayScreen(){
        displayLabel.text = currentInput
        
    }
    
}

extension ViewController{
    func configureButtons(in view: UIView) {
            for subview in view.subviews {
                if let button = subview as? UIButton {
                    styleButton(button)
                } else {
                    // Recursively check subviews
                    configureButtons(in: subview)
                }
            }
        }
        
        private func styleButton(_ button: UIButton) {
            button.layer.cornerRadius = 0.0
            button.layer.borderWidth = 1.0
            button.layer.borderColor = UIColor.black.cgColor
        }
    
    
}

