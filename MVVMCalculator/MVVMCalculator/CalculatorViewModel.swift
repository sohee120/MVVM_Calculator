//
//  CalculatorViewModel.swift
//  MVVMCalculator
//
//  Created by 윤소희 on 2023/07/26.
//

import Foundation
import RxSwift
import RxCocoa

class CalculatorViewModel {
    
    var displayText = BehaviorRelay<String>(value:"0")
    var operation = BehaviorRelay<String>(value: "")
    let numberBtnOn = PublishRelay<String>()
    let operationBtnOn = PublishRelay<String>()
    private let disposeBag = DisposeBag()
    private var errorState: Bool = false
    private var calculator = CalculatorModel()
    private var userIsInTheMiddleOfTyping: Bool = false
    
    init() {
        numberBtnOn
            .subscribe(onNext: {[weak self] digit in
                self?.inputDigit(digit: digit)
            })
            .disposed(by: disposeBag)
        
        operationBtnOn
            .subscribe(onNext: {[weak self] operation in
                self?.inputOperation(operation: operation)
            })
            .disposed(by: disposeBag)
    }
    
    private var displayValue: Double {
        get{
            return Double(displayText.value)!
        }
        set{
            displayText.accept(String(newValue))
        }
    }
    
    private func inputDigit(digit: String) {
        if userIsInTheMiddleOfTyping {
            displayText.accept(displayText.value + digit)
            print(digit)
        }else{
            displayText.accept(digit)
            print(digit)
        }
        userIsInTheMiddleOfTyping = true
    }
    
    private func inputOperation(operation: String) {
        if userIsInTheMiddleOfTyping {
            calculator.setOperand(operand: displayValue)
            userIsInTheMiddleOfTyping = false
        }
        calculator.performOperation(symbol: operation)
        displayText.accept(String(calculator.result))
    }
}


