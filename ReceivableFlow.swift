//
//  recceivableFlow.swift
//  MSGTest
//
//  Created by 동현 on 2022/05/12.
//

import Foundation
import RxFlow

class ReceivableFlow: Flow{
    
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
           case .ReceivableIsRequired:
               return self.navigateToReceivable()
           case .CalculatorIsRequired:
               
               return .end(forwardToParentFlowWithStep: DemoStep.CalculatorIsRequired)
               
           }
       }
       
       private func navigateToReceivable() -> FlowContributors {
           let viewController = ReceivableVC()
           self.rootViewController.setViewControllers([viewController], animated: false)
           return .one(flowContributor: .contribute(withNext: viewController))
       }
}
