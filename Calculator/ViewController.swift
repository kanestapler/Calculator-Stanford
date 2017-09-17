//
//  ViewController.swift
//  Calculator
//
//  Created by Kane Stapler on 9/16/17.
//  Copyright © 2017 Kane Stapler. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var brain = CalculatorBrain ()
    
    @IBOutlet weak var display: UILabel!
    
    var userIsInTheMiddleOfTyping = false
    
    @IBAction func touchDigit(_ sender: UIButton) {
        let digitTouched = sender.currentTitle!
        print("\(digitTouched) was touched")
        if userIsInTheMiddleOfTyping {
            display.text! += digitTouched
        } else {
            display.text! = digitTouched
            userIsInTheMiddleOfTyping = true
        }
        
    }
    
    var displayNumber: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }
    
    @IBAction func mathmaticalFunction(_ sender: UIButton) {
        
        if userIsInTheMiddleOfTyping {
            brain.setOperand(displayNumber)
            userIsInTheMiddleOfTyping = false
        }
        
        brain.performOperation(sender.currentTitle!)
        
        if let outcome = brain.result {
            displayNumber = outcome
        }
    }
}

