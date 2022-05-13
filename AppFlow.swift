//
//  AppFlow.swift
//  MSGTest
//
//  Created by 동현 on 2022/05/12.
//

import RxFlow

class AppFlow: Flow{
    
    var window: UIWindow
       
       var root: Presentable {
           return self.window
       }

       init(window: UIWindow) {
           self.window = window
       }
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? DemoStep else { return .none }
            switch step {
            case .CalculatorIsRequired:
                return self.navigateToCalculator()
            case .ReceivableIsRequired:
                return self.navigateToReceivable()
            }
    }
    
    private func navigateToCalculator() -> FlowContributors {
        let
        calculatorFlow = CalculatorFlow()
        Flows.use(calculatorFlow, when: .created) { (root) in
            self.window.rootViewController = root
        }
        return .one(flowContributor: .contribute(withNextPresentable: calculatorFlow, withNextStepper: OneStepper(withSingleStep: DemoStep.CalculatorIsRequired)))
    }

    private func navigateToReceivable() -> FlowContributors {
        let receivableFlow = ReceivableFlow()
        Flows.use(receivableFlow, when: .created) { (root) in
            self.window.rootViewController = root
        }
        return .one(flowContributor: .contribute(withNextPresentable: receivableFlow, withNextStepper: OneStepper(withSingleStep: DemoStep.ReceivableIsRequired)))

    
    
   
  
    
    
}
}
