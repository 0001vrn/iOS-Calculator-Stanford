//
//  CalculatorBrain.swift
//  stanford-calculator
//
//  Created by BSW123 on 03/07/17.
//  Copyright © 2017 BSW123. All rights reserved.
//

import Foundation


class CalculatorBrain
{
    
    private var accumulator = 0.0
    
    func setOperand(operand: Double){
        accumulator = operand
    }
    
    private var operations: Dictionary<String,Operation> = [
        "π": Operation.Constant(M_PI),
        "e": Operation.Constant(M_E),
        "±":Operation.UnaryOperation({ -$0 }),
        "√": Operation.UnaryOperation(sqrt),
        "cos": Operation.UnaryOperation(cos),
        "✖️": Operation.BinaryOperation({ $0 * $1 }),
        "➗": Operation.BinaryOperation({ $0 / $1 }),
        "➕": Operation.BinaryOperation({ $0 + $1 }),
        "➖": Operation.BinaryOperation({ $0 - $1 }),
        "=": Operation.Equals
    ]
    
    private enum Operation {
        case Constant(Double)
        case UnaryOperation((Double)->Double)
        case BinaryOperation((Double,Double)->Double)
        case Equals
    }
    
    func performOperation(symbol: String){
        if let operation = operations[symbol]
        {
            switch operation
            {
            case .Constant(let value): accumulator = value
                break
            case .UnaryOperation(let foo): accumulator = foo(accumulator)
                break
            case .BinaryOperation(let foo): pending = PendingBinaryOperationInfo(binaryFunction: foo, firstOperand: accumulator)
                break
            case .Equals:
                if pending != nil
                {
                    accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator)
                    pending = nil
                }
                break
            
            }
        }
        
        
        
    }
    
    private var pending: PendingBinaryOperationInfo?
    
    private struct PendingBinaryOperationInfo {
        var binaryFunction: (Double,Double)->Double
        var firstOperand: Double
    }
    
    var result: Double{
        get{
            return accumulator;
        }
    }
    
}
