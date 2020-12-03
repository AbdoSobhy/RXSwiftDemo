//
//  Alert+Extension.swift
//  RXSwiftDemo
//
//  Created by Abdelrahman Sobhy on 12/3/20.
//  Copyright © 2020 Macbook pro. All rights reserved.
//

import UIKit

extension UIViewController{
    func alert(title: String = "", message: String, actions: [(String, UIAlertAction.Style)]) {
        
        let alerting = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for action in actions {
            alerting.addAction(UIAlertAction(title: action.0, style: action.1, handler: nil))
        }
        self.present(alerting, animated: true, completion: nil)
    }
    
    func alert(title: String = "", message: String, actions: [(String, UIAlertAction.Style, ((UIAlertAction) -> Void)? )]) {
        
        let alerting = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for action in actions {
            alerting.addAction(UIAlertAction(title: action.0, style: action.1, handler: action.2))
        }
        self.present(alerting, animated: true, completion: nil)
    }
    


}
