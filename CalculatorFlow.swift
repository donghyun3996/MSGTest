//
//  CalculatorFlow.swift
//  MSGTest
//
//  Created by 동현 on 2022/05/12.
//

import Foundation
import RxFlow

class CalculatorFlow: Flow{
    
    var root: Presentable {
         return self.rootViewController
     }

     private lazy var rootViewController: UINavigationController = {
         let viewController = UINavigationController()
         return viewController
     }()

     init() {}

     func navigate(to step: Step) -> FlowContributors {
         guard let step = step as? DemoStep else { return .none }
         switch step {
         case .CalculatorIsRequired:
             return self.navigateToCalculator()
         case .ReceivableIsRequired:
            
             return .end(forwardToParentFlowWithStep: DemoStep.ReceivableIsRequired)
             
         }
         
     }
     
     private func navigateToCalculator() -> FlowContributors {
         let viewController = CalculatorVC()
         self.rootViewController.setViewControllers([viewController], animated: false)
         
         return .one(flowContributor: .contribute(withNext: viewController))
     }
 }

