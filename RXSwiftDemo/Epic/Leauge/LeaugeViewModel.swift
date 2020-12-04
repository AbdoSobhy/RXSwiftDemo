//
//  LeaugeViewModel.swift
//  RXSwiftDemo
//
//  Created by Abdelrahman Sobhy on 12/3/20.
//  Copyright © 2020 Macbook pro. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class LeaugeViewModel {
    var repo: LeaugeRepo
    private var leaugeSubject = PublishSubject<[Leagues]>()
    var leauge: Observable<[Leagues]>{return leaugeSubject}
    var errorMessage = BehaviorRelay<String>(value: "")
    var activityIndicator = BehaviorRelay<Bool>(value: false)
    private var isTableViewHidden = BehaviorRelay<Bool>(value: false)
    var tableViewObserver: Observable<Bool> {return isTableViewHidden.asObservable()}
    
    
    init(repo: LeaugeRepo) {
        self.repo = repo
    }
    
    func getLeauge() {
        self.activityIndicator.accept(true)
        repo.getLeauge { [weak self] response in
            switch response {
            case .success(let leauge):
                self?.leaugeSubject.onNext(leauge)
                self?.isTableViewHidden.accept(false)
            case .failure(let error):
                self?.isTableViewHidden.accept(true)
                self?.errorMessage.accept(error.localizedDescription)
            }
            self?.activityIndicator.accept(false)
        }
    }
}
