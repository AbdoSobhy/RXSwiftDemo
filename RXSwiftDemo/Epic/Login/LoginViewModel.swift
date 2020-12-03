//
//  LoginViewModel.swift
//  RXSwiftDemo
//
//  Created by Abdelrahman Sobhy on 12/2/20.
//  Copyright © 2020 Macbook pro. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class LoginViewModel {
    
    var loginRepo: AuthenticationsRepo
    
    var usernameBehavior = BehaviorRelay<String>(value: "")
    var passwordBehavior = BehaviorRelay<String>(value: "")
    var errorMessage = BehaviorRelay<String>(value: "")
    var loadingIndecator = BehaviorRelay<Bool>(value: false)

    private var loginResponseModel = PublishSubject<Login>()

    var loginResponse : Observable<Login> {
        return loginResponseModel
    }
    
    var isValidUsername : Observable<Bool> {
        usernameBehavior.asObservable().map { username -> Bool in
            let emptyUsername = username.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            return emptyUsername
        }
    }
    
    var isValidPassword : Observable<Bool> {
        passwordBehavior.asObservable().map { password -> Bool in
            let emptyPassword = password.isEmpty
            return emptyPassword
        }
    }
    
    var isLoginBtnEnabled : Observable<Bool> {
        Observable.combineLatest(isValidUsername,isValidPassword) { (isValidUsername, isValidPassword) in
            let isLoginBtnEnabled = !isValidUsername && !isValidPassword
            return isLoginBtnEnabled
        }
    }


    
    init(loginRepo: AuthenticationsRepo) {
        self.loginRepo = loginRepo
    }
    func performLogin() {
        self.loadingIndecator.accept(true)
        loginRepo.login(username: self.usernameBehavior.value, Password: self.passwordBehavior.value) { [weak self] response in
            switch response {
            case .success(let login):
                self?.loginResponseModel.onNext(login)
            case .failure(let error):
                self?.errorMessage.accept(error.localizedDescription)
            }
            self?.loadingIndecator.accept(false)
        }
    }
}
