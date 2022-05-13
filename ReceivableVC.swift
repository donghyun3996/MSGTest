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
    
    
    private let BackNavigationButtonButton = UIButton().then {
        $0.setTitle("뒤로가기", for: .normal)
        $0.backgroundColor = .systemBlue
        $0.addTarget(self, action: #selector(
            BackNavigationButtonDidTap), for: .touchUpInside)
            
        }
    
    
    //MARK:- Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
                
        configurUI()
    }
    
    
    //MARK:- Helpers
    
    func configurUI(){
        addsubView()
        setLayout()
        
      }
      
      
      func setLayout(){
          BackNavigationButtonButton.snp.makeConstraints{
              $0.leading.trailing.bottom.equalToSuperview().inset(20)
              $0.height.equalTo(50)
          }
      }
      
      
      func addsubView(){
          view.addSubview(BackNavigationButtonButton)
      }
      

    
    //Actions
    
    @objc func BackNavigationButtonDidTap(){
        
       self.steps.accept(DemoStep.CalculatorIsRequired)
    }
    
}
