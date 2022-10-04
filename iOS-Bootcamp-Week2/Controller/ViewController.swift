//
//  ViewController.swift
//  iOS-Bootcamp-Week2
//
//  Created by Asım can Yağız on 1.10.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var mainScreenLabel: UILabel!
    @IBOutlet weak var bottomScreenLabel: UILabel!
    
    var calculationInputs: [String] = ["0", "", "0"]
    var number: String = ""
    var result: Double = 0.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //MARK: - buttonTouched
    @IBAction func buttonTouched(_ sender: UIButton) {
        UIButton.animate(withDuration: 0.1,
                         animations: {
            sender.transform = CGAffineTransform(scaleX: 0.975, y: 0.96)
        },
                         completion: { finish in
            UIButton.animate(withDuration: 0.1, animations: {
                sender.transform = CGAffineTransform.identity
            })
        })
    }
    
    //MARK: - numberPressed()
    //Function for save the inputs user pressed
    @IBAction func numberPressed(_ sender: UIButton) {
        let input = sender.titleLabel?.text
        switch input {
        case ",":
            number += "."
        default:
            number += input!
        }
        
        mainScreenLabel.text = number
        
    }
    
    //MARK: - operationPressed
    //Function for start process with user inputs and operation choice
    @IBAction func operationPressed(_ sender: UIButton) {
        let operation = sender.titleLabel?.text
        
        
        if calculationInputs[0] == "0" || calculationInputs[0] == "" || calculationInputs[0] == "0.0" {
            calculationInputs[0] = number
            
        } else if calculationInputs[2] == "0" || calculationInputs[2] == "" || calculationInputs[2] == "0.0" {
            calculationInputs[2] = number
            
        }
        
        //Basic 4 operation of mathematics
        switch operation {
        case "+":
            operationInputChecked(operation ?? "+")
        case "-":
            operationInputChecked(operation ?? "-")
        case "x":
            operationInputChecked(operation ?? "x")
        case "÷":
            operationInputChecked(operation ?? "÷")
        case "C":
            calculationInputs = ["0", "", "0"]
            mainScreenLabel.text = "0"
            bottomScreenLabel.text = "0"
            number = ""
            
            // Changes the number with opposite
        case "+/-":
            operationInputChecked(operation ?? "")
            if calculationInputs[2] == "0" || calculationInputs[2] == "" || calculationInputs[2] == "0.0" {
                let reversed = "-" + mainScreenLabel.text!
                calculationInputs[2] = calculationInputs[0]
                calculationInputs[0] = String((Double(calculationInputs[0]) ?? 0) - (Double(calculationInputs[2]) ?? 0))
                calculationInputs[2] = "0"
                calculationInputs[1] = ""
                number = ""
                mainScreenLabel.text = reversed
            }
            
            // Mod operation for divide %100
        case "%":
            if calculationInputs[0] == "0" || calculationInputs[0] == "" || calculationInputs[0] == "0.0" {
                bottomScreenLabel.text = number + "%"
                calculationInputs[0] = number
                number = String((Double(number) ?? 0) / 100)
                mainScreenLabel.text = number
                
                calculationInputs[0] = number
                
            } else {
                bottomScreenLabel.text = calculationInputs[0] + "%"
                number = String(Double(calculationInputs[0])! / 100)
                mainScreenLabel.text = number
                
                calculationInputs[0] = number
                
            }
            calculationInputs[1] = ""
            number = ""
            
            // Square function
        case "x²":
            
            if number == "" {
                bottomScreenLabel.text = calculationInputs[0] + "²"
                calculationInputs[0] = String(pow(Double(calculationInputs[0]) ?? 1, 2))
            } else {
                calculationInputs[0] = String(pow(Double(number)!, 2))
                calculationInputs[2] = ""
                
                bottomScreenLabel.text = number + "²"
                number = ""
            }
            mainScreenLabel.text = calculationInputs[0]
            calculationInputs[1] = ""
            
            //Factorial
        case "x!":
            
            if number != "" {
                bottomScreenLabel.text = number + "!"
                var factorial = 1
                for i in 1...Int(number)!{
                    if factorial > 500000 {
                        mainScreenLabel.text = "Error!"
                        return
                    }
                    factorial = factorial * i
                }
                
                number = String(factorial)
                calculationInputs[0] = number
                calculationInputs[2] = ""
                number = ""
                mainScreenLabel.text = calculationInputs[0]
            } else if calculationInputs[0] != "" && calculationInputs[0] != "0" {
                bottomScreenLabel.text = calculationInputs[0] + "!"
                var factorial = 1
                let goalNumber = Int(calculationInputs[0]) ?? 1
                if goalNumber == 1 {
                    mainScreenLabel.text = "Error!"
                    return
                }
                for i in 1...goalNumber {
                    if factorial > 500000 {
                        mainScreenLabel.text = "Error!"
                        return
                    }
                    factorial = factorial * i
                }
                
                number = String(factorial)
                calculationInputs[0] = number
                calculationInputs[2] = ""
                number = ""
                mainScreenLabel.text = calculationInputs[0]
            }
            calculationInputs[1] = ""
            
            //Square Root
        case "√x":
            if number != "" {
                bottomScreenLabel.text = "√" + number  
                calculationInputs[0] = String(sqrt(Double(number)!))
                mainScreenLabel.text = calculationInputs[0]
                number = ""
            } else {
                bottomScreenLabel.text = "√" + calculationInputs[0]
                calculationInputs[0] = String(sqrt(Double(calculationInputs[0]) ?? 0))
                mainScreenLabel.text = calculationInputs[0]
            }
            calculationInputs[1] = ""
            calculationInputs[2] = ""
        case "=":
            resultOfOperation()
        default:
            return
        }
        
    }
    
    //MARK: - resultOfOperation()
    // This function makes the basic 4 operations
    func resultOfOperation() {
        switch calculationInputs[1] {
        case "+":
            result = Double(calculationInputs[0])! + (Double(calculationInputs[2]) ?? 0)
        case "-":
            result = Double(calculationInputs[0])! - (Double(calculationInputs[2]) ?? 0)
        case "x":
            result = Double(calculationInputs[0])! * (Double(calculationInputs[2]) ?? 1)
        case "÷":
            result = Double(calculationInputs[0])! / (Double(calculationInputs[2]) ?? 1)
        default:
            return
        }
        
        bottomScreenLabel.text = calculationInputs[0] + calculationInputs[1] + calculationInputs[2] + " = " + String(result)
        calculationInputs[0] = String(result)
        calculationInputs[2] = "0"
        
        number = ""
        mainScreenLabel.text = String(result)
    }
    
    //MARK: - operationInputChecked
    //This function checked operation inputs and make choice for them
    func operationInputChecked(_ operation: String){
        if calculationInputs[1] == "" {
            calculationInputs[1] = operation
            number = ""
            
        } else {
            resultOfOperation()
            calculationInputs[1] = operation
        }
    }
    
}

