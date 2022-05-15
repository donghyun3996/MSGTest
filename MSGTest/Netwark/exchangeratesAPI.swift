//
//  exchangeratesAPI.swift
//  MSGTest
//
//  Created by 동현 on 2022/05/14.
//

import Foundation
import Moya
import RxSwift


    
enum exchangeratesAPI{
    case exchage(remittanceCountry: String,sendingCountry: String, amount: String,date: String)
}


extension exchangeratesAPI: TargetType{
    
    var baseURL: URL {
        return URL(string: "https://api.apilayer.com/currency_data/convert?&apikey=1FuLo2aKGCIWDvLRfZ4PbBNbc88sMwZB")!
    }
    
    var path: String {
//        print("eww")
        switch self{
        case .exchage(let remittanceCountry, let sendingCountry,let amount, let date):
            print(sendingCountry)
            return "&from=\(remittanceCountry)&to=\(sendingCountry)&amount=\(amount)&date=\(date)"
            
            
//        https://api.apilayer.com/currency_data/convert?&apikey=TMq3mUCMLtGSGtSzB00JBE48Zr0mqEdx&from=USD&to=EUR&amount=5&date=2022-05-14
        }
        
    }

    var method: Moya.Method {
        switch self{
    case .exchage(_,_,_,_):
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .exchage(let remittanceCountry, let sendingCountry, let amount, let date):
                   let params: [String: Any] = [
                    "remittanceCountry" : remittanceCountry as Any,
                    "sendingCountry" : sendingCountry as Any,
                    "amount" : amount as Any,
                    "date" : date as Any
                      ]
                   return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
               }
    }
    
    var headers: [String : String]? {
        return ["Content-Type":"application/json"]
    }
    
    
}

