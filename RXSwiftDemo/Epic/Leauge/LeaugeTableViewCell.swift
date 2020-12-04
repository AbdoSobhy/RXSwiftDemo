//
//  LeaugeTableViewCell.swift
//  RXSwiftDemo
//
//  Created by Abdelrahman Sobhy on 12/3/20.
//  Copyright © 2020 Macbook pro. All rights reserved.
//

import UIKit

class LeaugeTableViewCell: UITableViewCell {
    @IBOutlet weak var leaugeName: UILabel!
    @IBOutlet weak var sport: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(leauge: Leagues){
        self.leaugeName.text = leauge.strLeague
        self.sport.text = leauge.strSport
    }

}
