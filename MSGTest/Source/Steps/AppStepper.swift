//
//  AppStepper.swift
//  MSGTest
//
//  Created by 동현 on 2022/05/12.
//

import UIKit
import RxFlow
import RxSwift
import RxRelay

class AppStepper: Stepper {

    let steps = PublishRelay<Step>()
    private let disposeBag = DisposeBag()

    init() {}

    var initialStep: Step {
        return DemoStep.CalculatorIsRequired
    }
}
