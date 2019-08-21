//
//  File.swift
//  RxSwiftTest
//
//  Created by 陳鍵群 on 2019/8/21.
//  Copyright © 2019 陳鍵群. All rights reserved.
//

import RxSwift

class MainViewModel  {
    let userNameValid: Observable<Bool>
    let passwordValid: Observable<Bool>
    let everythingValid: Observable<Bool>
    
    init(userName: Observable<String>, password: Observable<String>) {
        userNameValid = userName.map{ $0.count > 3 }
        passwordValid = password.map{ $0.count > 3 }
        everythingValid = Observable.combineLatest( userNameValid, passwordValid ) { $0 && $1 }.share(replay: 1)
    }
    
}
