//
//  Calculator.swift
//  MSGTest
//
//  Created by 동현 on 2022/05/12.
//


import UIKit
import RxFlow
import RxCocoa
import SnapKit
import Then
import RxRelay


class CalculatorVC: UIViewController, Stepper{
    
    
    //MARK:- Propertise
    var steps = PublishRelay<Step>()
    
    
    private let exchangeRateCalculationButton =  UIButton().then {
        $0.setTitle("환률 계산", for: .normal)
        $0.backgroundColor = .systemBlue
        $0.addTarget(self, action: #selector(exchangeRateCalculationButtonDidTap), for: .touchDown)
        }
    
    
    //MARK:- Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurUI()
        view.backgroundColor = .white
    }
    
    
    //MARK:- Helpers
    
    func configurUI(){
        addsubView()
        setLayout()
        
      }
    
    func addsubView(){
        view.addSubview(exchangeRateCalculationButton)
    }
    
      
      func setLayout(){
          exchangeRateCalculationButton.snp.makeConstraints{
              $0.leading.trailing.bottom.equalToSuperview().inset(20)
              
              $0.height.equalTo(50)
          }
      }
      
      
     

    
    //Actions
    
    @objc func exchangeRateCalculationButtonDidTap(){
        
        self.steps.accept(DemoStep.ReceivableIsRequired)
       
    }
    
}
