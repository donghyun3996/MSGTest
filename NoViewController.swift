//
//  NoViewController.swift
//  
//
//  Created by 동현 on 2022/05/14.
//

import UIKit
import ReactorKit
import RxSwift

final class NoViewController: UIViewController{
    
    var disposeBag: DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func bind(reactor: NoReactorView) {
        //binding here
    }
    
}
