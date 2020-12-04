//
//  LeaugeViewController.swift
//  RXSwiftDemo
//
//  Created by Abdelrahman Sobhy on 12/3/20.
//  Copyright © 2020 Macbook pro. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class LeaugeViewController: UIViewController {
    
    @IBOutlet weak var leaugeTableView: UITableView!
    @IBOutlet weak var tableViewView: UIView!
    @IBOutlet weak var activitiyIndecator: UIActivityIndicatorView!
    
    var viewModel = LeaugeViewModel(repo: LeaugeRepoImpl())
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel.getLeauge()
        self.leaugeResponse()
        self.activityIndicator()
        self.errorMessage()
        self.tableViewObserver()
    }
    
    func leaugeResponse() {
        self.viewModel.leauge.bind(to: leaugeTableView.rx.items(cellIdentifier: "LeaugeTableViewCell", cellType: LeaugeTableViewCell.self)) {(row, leauge, cell) in
            cell.configure(leauge: leauge)
        }.disposed(by: disposeBag)
        
        // select item
        Observable.zip(leaugeTableView.rx.itemSelected,leaugeTableView.rx.modelSelected(Leagues.self)).bind { [weak self] indexPath, leauge in
            print(indexPath.row)
            self?.alert(message: leauge.strLeagueAlternate ?? "No Alternative League", actions: [("Thanks", .cancel)])
        }.disposed(by: disposeBag)
    }
    
    func activityIndicator() {
        self.viewModel.activityIndicator.subscribe(onNext: { [weak self] isSpanning in
            isSpanning ? self?.activitiyIndecator.startAnimating() : self?.activitiyIndecator.stopAnimating()
            }).disposed(by: disposeBag)
    }

    func errorMessage() {
        self.viewModel.errorMessage.subscribe(onNext: { [weak self] errorMessage in
            self?.alert(message: errorMessage, actions: [("OK", .cancel)])
            }).disposed(by: disposeBag)
    }
    
    func tableViewObserver() {
        self.viewModel.tableViewObserver.bind(to: tableViewView.rx.isHidden).disposed(by: disposeBag)
    }

    
    
}
