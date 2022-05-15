//
//  Calculator.swift
//  MSGTest
//
//  Created by 동현 on 2022/05/12.
//


import UIKit
import RxFlow
import RxCocoa
import RxSwift
import SnapKit
import Then
import RxRelay
import Alamofire
import Moya
import WebKit



class CalculatorVC: UIViewController, Stepper{
   
    let ExchangeProvider = MoyaProvider<exchangeratesAPI>()
    
    
    //MARK:- Propertise
    
    
    var steps = PublishRelay<Step>()
    
    private let disposeBag = DisposeBag()

    var textField = 1
    
 
    let nowDate = Date()

    let dateFormatter = DateFormatter()
    
            
    
    private let exchangeRateCalculationButton =  UIButton().then {
        $0.setTitle("환률 계산", for: .normal)
        $0.backgroundColor = .systemBlue
        $0.addTarget(self, action: #selector(exchangeRateCalculationButtonDidTap), for: .touchDown)
        }
    
    private let exchangeRateCalculationLabel = UILabel().then{
        $0.text = "환률 계산"
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
    
    private let exchangeRateLabel = UILabel().then{
        $0.text = "       환률:"
        $0.font = .systemFont(ofSize: 16)
        $0.textAlignment = .right
    }
    
    private let lookupTimeLabel = UILabel().then{
        $0.text = "조회 시간:"
        $0.font = .systemFont(ofSize: 16)
    }
    
    private let remittanceAmountLabel = UILabel().then{
        $0.text = "    송금액:"
        $0.font = .systemFont(ofSize: 16)
    }
    
    let remittanceCountryTextField = UITextField().then{
        $0.text = "KRW"
        $0.backgroundColor = .white
        $0.addTarget(self, action: #selector(remittanceCountryTextFieldDidTap), for: .touchDown)
    }
    
    let sendingCountryTextFiled = UITextField().then{
        $0.text = "USD"
        $0.backgroundColor = .white
        $0.addTarget(self, action: #selector(sendingCountryTextFieldDidTap), for: .touchDown)
      
    }
    
    private let exchangeRateNumberLabel = UILabel().then{
        $0.text = ""
    }
    
    private let lookupTimeLabel2 = UILabel().then{
        $0.text = ""
    }
    
    private let remittanceCountryLabel2 = UILabel().then{
        $0.text = "KRW"
    }
    
    private let remittanceCountryNumberTextField = UITextField().then{
        $0.text = "1"
        
        $0.textAlignment = .center
    }
    
    var remittanceCountry = ""
    
    var sendingCountry = ""
    
    var selectedCountry = ""
    
    private let Country = [ "KRW", "USD", "JPY", "PHP" ]
    
    //MARK:- Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurUI()
        view.backgroundColor = .white
        createPickerView()
        
        dateFormatter.dateFormat = "yyyy-MM-dd-HH:mm"
        
        
    }
    
   
    
    //MARK:- Helpers
    
    func configurUI(){
        addsubView()
        setLayout()
        
        
      }
    
    func addsubView(){
        view.addSubview(exchangeRateCalculationButton)
        view.addSubview(exchangeRateCalculationLabel)
        view.addSubview(remittanceCountryLabel)
        view.addSubview(sendingCountryLabel)
        view.addSubview(exchangeRateLabel)
        view.addSubview(lookupTimeLabel)
        view.addSubview(remittanceAmountLabel)
        view.addSubview(remittanceCountryTextField)
        view.addSubview(sendingCountryTextFiled)
        view.addSubview(exchangeRateNumberLabel)
        view.addSubview(lookupTimeLabel2)
        view.addSubview(remittanceCountryLabel2)
        view.addSubview(remittanceCountryNumberTextField)
    }
    
      
      func setLayout(){
          exchangeRateCalculationButton.layer.cornerRadius = 10
          exchangeRateCalculationButton.snp.makeConstraints{
              $0.leading.trailing.equalToSuperview().inset(89)
              $0.centerX.equalToSuperview()
              $0.bottom.equalToSuperview().inset(65)
              $0.height.equalTo(50)
          }
          
          
          exchangeRateCalculationLabel.snp.makeConstraints{
              $0.top.equalToSuperview().inset(112)
              $0.centerX.equalToSuperview()
          }
          
          remittanceCountryLabel.snp.makeConstraints{
              $0.top.equalTo(exchangeRateCalculationLabel.snp_bottomMargin).offset(40)
              $0.leading.equalToSuperview().inset(50)
          }
          
          sendingCountryLabel.snp.makeConstraints{
              $0.top.equalTo(exchangeRateCalculationLabel.snp_bottomMargin).offset(90)
              $0.leading.equalToSuperview().inset(50)
          }
          exchangeRateLabel.snp.makeConstraints{
              $0.top.equalTo(exchangeRateCalculationLabel.snp_bottomMargin).offset(140)
              $0.leading.equalToSuperview().inset(50)
          }
          
          lookupTimeLabel.snp.makeConstraints{
              $0.top.equalTo(exchangeRateCalculationLabel.snp_bottomMargin).offset(190)
              $0.leading.equalToSuperview().inset(50)
          }
          remittanceAmountLabel.snp.makeConstraints{
              $0.top.equalTo(exchangeRateCalculationLabel.snp_bottomMargin).offset(240)
              $0.leading.equalToSuperview().inset(50)
          }
          
          
          remittanceCountryTextField.snp.makeConstraints{
              $0.top.equalTo(exchangeRateCalculationLabel.snp_bottomMargin).offset(40)
              $0.trailing.equalToSuperview().inset(40)
              $0.height.equalTo(18)
              
          }
          
          
          sendingCountryTextFiled.snp.makeConstraints{
              $0.top.equalTo(exchangeRateCalculationLabel.snp_bottomMargin).offset(90)
              $0.trailing.equalToSuperview().inset(40)
              $0.height.equalTo(18)
              
              }
          
          
          exchangeRateNumberLabel.snp.makeConstraints{
              $0.top.equalTo(exchangeRateCalculationLabel.snp_bottomMargin).offset(140)
              $0.trailing.equalToSuperview().inset(40)
                  }
          
          
          
          lookupTimeLabel2.snp.makeConstraints{
              $0.top.equalTo(exchangeRateCalculationLabel.snp_bottomMargin).offset(190)
              $0.trailing.equalToSuperview().inset(40)
            }
          
          
          remittanceCountryLabel2.snp.makeConstraints{
              $0.top.equalTo(exchangeRateCalculationLabel.snp_bottomMargin).offset(240)
              $0.trailing.equalToSuperview().inset(40)
            }
          
          remittanceCountryNumberTextField.snp.makeConstraints{
              $0.top.equalTo(exchangeRateCalculationLabel.snp_bottomMargin).offset(240)
              $0.trailing.equalToSuperview().inset(85)
              $0.width.equalTo(134)
          }
          remittanceCountryTextField.rx.text
              .bind(to: remittanceCountryLabel2.rx.text)
              .disposed(by: disposeBag)
          
          
          
          
          
          
         
      }
    
    
    func fetchLookDetail() {
        ExchangeProvider.request(.exchage(remittanceCountryTextField.text, remittanceCountryTextField.text, remittanceCountryNumberTextField.text, lookupTimeLabel2.text)) { response in
            
            switch response {
                case .success(let result):
                do {
                    print(try result.mapJSON())
                    } catch(let err) {
                        print("444444444")
                    }
                case .failure(let err):
                    print("555555555")
                }
            
            }
        
        
        }
    
      
    func createPickerView() {
        
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self

            
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let btnDone = UIBarButtonItem(title: "확인", style: .done, target: self, action: #selector(onPickDone))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        toolBar.setItems([ space , btnDone], animated: true)
        toolBar.isUserInteractionEnabled = true
            
        
        remittanceCountryTextField.inputView = pickerView
        remittanceCountryTextField.inputAccessoryView = toolBar
        
        
        sendingCountryTextFiled.inputView = pickerView
        sendingCountryTextFiled.inputAccessoryView = toolBar
        
        btnDone.rx.tap
            .bind{[weak self] in
            self?.onPickDone()
            }
            .disposed(by: disposeBag)
        
    }
    
    
   

    
    //Actions
    
    @objc func exchangeRateCalculationButtonDidTap(){
        
        self.steps.accept(DemoStep.ReceivableIsRequired)
        
       
    }
    @objc func sendingCountryTextFieldDidTap(){
        textField = 2
    }
    
    @objc func remittanceCountryTextFieldDidTap(){
        textField = 1
    }
    
    @objc func onPickDone() {
        
        fetchLookDetail()
        
        
        let str = dateFormatter.string(from: nowDate)
        lookupTimeLabel2.text = str
        
        switch textField {
        case 1:
            remittanceCountryTextField.text = "\(selectedCountry)"
            remittanceCountryTextField.resignFirstResponder()
        case 2:
            sendingCountryTextFiled.text = "\(selectedCountry)"
            sendingCountryTextFiled.resignFirstResponder()
        default:
            return
        }
    }
}

extension CalculatorVC: UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Country.count
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return "\(Country[row])"
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        selectedCountry = Country[row]
    }
}


