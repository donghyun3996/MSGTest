//
//  receivableVC.swift
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



class ReceivableVC: UIViewController, Stepper {
    
    //MARK:- Propertise
    var steps = PublishRelay<Step>()
 
    private let receivableLabel = UILabel().then{
        $0.text = "수취금"
        $0.frame = CGRect(x: 0, y: 0, width: 205, height: 38)
        $0.font = .systemFont(ofSize: 28, weight: .bold)
        
        
    }
    
    
    private let remittanceCountryLabel = UILabel().then{
        $0.text = "송금 국가:"
        $0.font = .systemFont(ofSize: 16)
    }
    
    
    private let sendingCountryLabel = UILabel().then{
        $0.text = "송취 국가:"
        $0.font = .systemFont(ofSize: 16)
    }
    
     let remittanceCountryLabel2 = UILabel().then{
        $0.text = ""
        $0.font = .systemFont(ofSize: 16)
    }
    
     let sendingCountryLabel2 = UILabel().then{
        $0.text = ""
        $0.font = .systemFont(ofSize: 16)
    }
    
    private let receivableAmountLabel = UILabel().then{
        $0.text = "121010101001"
        $0.font = .systemFont(ofSize: 28)
    }
    
    //MARK:- Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(BackNavigationButtonDidTap))
        configurUI()
    }
    
    
    //MARK:- Helpers
    
    func configurUI(){
        addsubView()
        setLayout()
        
      }
    
    func addsubView(){
        
        view.addSubview(receivableLabel)
        view.addSubview(remittanceCountryLabel)
        view.addSubview(remittanceCountryLabel2)
        view.addSubview(sendingCountryLabel)
        view.addSubview(sendingCountryLabel2)
        view.addSubview(receivableAmountLabel)
    }
      
      
      func setLayout(){
          
          
          
          receivableLabel.snp.makeConstraints{
              $0.top.equalToSuperview().inset(112)
              $0.centerX.equalToSuperview()
          }
          
          remittanceCountryLabel.snp.makeConstraints{
              $0.top.equalTo(receivableLabel.snp_bottomMargin).offset(40)
              $0.leading.equalToSuperview().inset(50)
          }
          
          sendingCountryLabel.snp.makeConstraints{
              $0.top.equalTo(receivableLabel.snp_bottomMargin).offset(90)
              $0.leading.equalToSuperview().inset(50)
          }
          
          remittanceCountryLabel2.snp.makeConstraints{
              $0.top.equalTo(receivableLabel.snp_bottomMargin).offset(40)
              $0.trailing.equalToSuperview().inset(40)
              
              
          }
          
          sendingCountryLabel2.snp.makeConstraints{
              $0.top.equalTo(receivableLabel.snp_bottomMargin).offset(90)
              $0.trailing.equalToSuperview().inset(40)
              
              
              }
          receivableAmountLabel.snp.makeConstraints{
              $0.top.equalTo(receivableLabel.snp_bottomMargin).offset(194)
              $0.centerX.equalToSuperview()
          }
          
          
          
      } 
      
      
      
      

    
    //Actions
    
    @objc func BackNavigationButtonDidTap(){
        
       self.steps.accept(DemoStep.CalculatorIsRequired)
    }
    
}
