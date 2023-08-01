//
//  ViewController.swift
//  MVVMCalculator
//
//  Created by 윤소희 on 2023/07/26.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var displayLabel: UILabel!
    private var viewModel = CalculatorViewModel() // 뷰 모델 인스턴스
    private let disposeBag = DisposeBag()
    //  private var userIsInTheMiddleOfTyping: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        // Do any additional setup after loading the view.
    }
    
    
    func bindViewModel () {
        viewModel.displayText
            .bind(to: self.displayLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    
    @IBAction func touchDigit(_ sender: UIButton) {
        guard let digit = sender.titleLabel!.text else {return}
        viewModel.numberBtnOn.accept(digit)
    }
    
    @IBAction func touchOperation(_ sender: UIButton) {
        guard let operation = sender.titleLabel!.text else {return}
        viewModel.operationBtnOn.accept(operation)
    }
}



