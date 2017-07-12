//
//  ViewController.swift
//  stanford-calculator
//
//  Created by BSW123 on 28/06/17.
//  Copyright © 2017 BSW123. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    var userIsInTheMiddleOfTyping = false
    
    @IBAction func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTyping
        {
            let textCurrentlyInDisplay = display.text!
            display.text = textCurrentlyInDisplay + digit
        }
        else
        {
            display.text = digit
        }
        
        userIsInTheMiddleOfTyping = true
    }

    var displayValue: Double{
        get{
            return Double(display.text!)!
        }
        set{
            display.text = String(newValue)
        }
    }
    
    private var brain = CalculatorBrain()
    
    @IBAction func performOperation(_ sender: UIButton)
    {
        
        if userIsInTheMiddleOfTyping
        {
            brain.setOperand(operand: displayValue)
            userIsInTheMiddleOfTyping = false
        }
        if let mathematicalSymbol = sender.currentTitle
        {
            brain.performOperation(symbol: mathematicalSymbol)
        }
        
        displayValue = brain.result
    }

}

