//
//  LoginViewController.swift
//  RXSwiftDemo
//
//  Created by Abdelrahman Sobhy on 12/2/20.
//  Copyright © 2020 Macbook pro. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class LoginViewController: UIViewController {
    @IBOutlet weak var userNameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var disposeBag = DisposeBag()
    var viewModel = LoginViewModel(loginRepo: AuthenticationsRepoImpl())
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.bindData()
        self.loginSuccessModel()
        self.loginBtnWasTapped()
        self.loginBtnIsEnable()
        self.loadingIndecator()
        self.errorMessage()
    }
    
    func bindData() {
        self.userNameTF.rx.text.orEmpty.bind(to: viewModel.usernameBehavior).disposed(by: disposeBag)
        self.passwordTF.rx.text.orEmpty.bind(to: viewModel.passwordBehavior).disposed(by: disposeBag)
    }
    
    func loginSuccessModel(){
        self.viewModel.loginResponse.subscribe(onNext: { loginModel in
            // handle of user logged successfully
            }).disposed(by: disposeBag)
    }
    
    func loginBtnWasTapped(){
        self.loginBtn.rx.tap.throttle(RxTimeInterval.milliseconds(500), scheduler: MainScheduler.instance).subscribe(onNext: { [weak self] (_) in
            self?.viewModel.performLogin()
        }).disposed(by: disposeBag)
    }
    
    func loginBtnIsEnable(){
        self.viewModel.isLoginBtnEnabled.bind(to: loginBtn.rx.isEnabled).disposed(by: disposeBag)
    }
    
    func loadingIndecator(){
        self.viewModel.loadingIndecator.subscribe(onNext: { [weak self] isSpanning in
            isSpanning ? self?.activityIndicator.startAnimating() : self?.activityIndicator.stopAnimating()
            }).disposed(by: disposeBag)
    }
    
    func errorMessage(){
        self.viewModel.errorMessage.subscribe(onNext: { errorMessage in
            // handle if username or password is wrong
            }).disposed(by: disposeBag)
    }
}
