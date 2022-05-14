//
//  NoReactorView.swift
//  
//
//  Created by 동현 on 2022/05/14.
//

import Foundation
import ReactorKit
import RxSwift

final class NoReactorView: Reactor {
    
    private let disposeBag: DisposeBag = .init()
    
    //MARK: - Reactor
    enum Action {
        // actiom cases
    }
    
    enum Mutation {
        // mutation cases
    }
    
    struct State {
        //state
    }
    
    let initialState: State
    
    init() {
        // init state initialState = State(...)
    }

}

//MARK: - Mutate
extension NoReactorView {
    func mutate(action: Action) -> Observable<Mutation> {
        // switch action {
        // }
    }
}

//MARK: - reduce
extension NoReactorView {
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        // switch mutation {
        // }
        return newState
    }
}
