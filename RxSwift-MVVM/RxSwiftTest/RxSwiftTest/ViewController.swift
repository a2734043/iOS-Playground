//
//  ViewController.swift
//  RxSwiftTest
//
//  Created by 陳鍵群 on 2019/8/20.
//  Copyright © 2019 陳鍵群. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ViewController: UIViewController {

    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmButton: UIButton!
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mainViewModel = MainViewModel(userName: userName.rx.text.orEmpty.asObservable(), password: password.rx.text.orEmpty.asObservable())
        
        mainViewModel.userNameValid.bind(to: password.rx.isEnabled).disposed(by: disposeBag)
        mainViewModel.passwordValid.bind(to: confirmButton.rx.isEnabled).disposed(by: disposeBag)
        
        confirmButton.rx.tap.bind { [weak self] in
            guard let strongSelf = self else {
                return
            }
            strongSelf.login()
        }.disposed(by: disposeBag)
        
        confirmButton.rx.tap.subscribe{ [weak self] in
            guard let strongSelf = self else {
                return
            }
            strongSelf.login()
        }.disposed(by: disposeBag)
        
        
//        let userNameValid = userName.rx.text.orEmpty.map{$0.count > 3}.share(replay: 1)
//        let passwordValid = password.rx.text.orEmpty.map({$0.count > 3})
//        let confirmBtnValid = Observable.combineLatest(userNameValid, passwordValid){ $0 && $1 }
//
//        userNameValid.bind(to: password.rx.isEnabled).disposed(by: disposeBag)
//        confirmBtnValid.bind(to: confirmButton.rx.isEnabled).disposed(by: disposeBag)
//

        
        // Do any additional setup after loading the view.
    }

    func login(){
        
    }

}

