//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Kane Stapler on 9/17/17.
//  Copyright © 2017 Kane Stapler. All rights reserved.
//

import Foundation

func changeSign(operand: Double) -> Double {
    return -operand
}

func multiply(op1: Double, op2: Double) -> Double {
    return op1 * op2
}

struct CalculatorBrain {
    
    private var accumulator: Double?
    
    private enum Operation {
        case constant(Double)
        case unaryOperation((Double) -> Double)
        case binaryOperation((Double, Double) -> Double)
        case equals
    }
    
    private var operations: Dictionary<String, Operation> = [
        "π" : .constant(Double.pi),
        "e" : .constant(M_E),
        "√" : .unaryOperation(sqrt),
        "±" : .unaryOperation(changeSign),
        "cos": .unaryOperation(cos),
        "=" : .equals,
        "×" : .binaryOperation({$0 * $1}),
        "÷" : .binaryOperation({$0 / $1}),
        "+" : .binaryOperation({$0 + $1}),
        "−" : .binaryOperation({$0 - $1})
    ]
    
    mutating func performOperation(_ symbol: String) {
        if let operation = operations[symbol] {
            switch operation {
            case .constant(let value):
                accumulator = value
            case .unaryOperation(let function):
                if accumulator != nil {
                    accumulator = function(accumulator!)
                }
            case .binaryOperation(let function):
                pendingBinaryOperation = PendingBinaryOperation(function: function, firstOperand: accumulator!)
                accumulator = nil
            case .equals:
                performPendingBinaryOperation()
            }
            
        }
    }
    
    private mutating func performPendingBinaryOperation() {
        if accumulator != nil && pendingBinaryOperation != nil {
            accumulator = pendingBinaryOperation!.perform(with: accumulator!)
            pendingBinaryOperation = nil
        }
    }
    
    private var pendingBinaryOperation: PendingBinaryOperation?
    
    private struct PendingBinaryOperation {
        var function: (Double, Double) -> Double
        var firstOperand: Double
        
        func perform(with secondOperand: Double) -> Double {
            return function(firstOperand, secondOperand)
        }
    }
    
    mutating func setOperand (_ operand: Double) {
        accumulator = operand
    }
    
    var result: Double? {
        get {
            return accumulator
        }
    }
}
