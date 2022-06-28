//
//  ActivityIndicator.swift
//  iosApp
//
//  Created by Carlos Cortés Sánchez on 5/11/21.
//  Copyright © 2021 orgName. All rights reserved.
//

import UIKit

public protocol ActivityIndicatorPresenter {
    
    var activityIndicator: UIActivityIndicatorView { get }
    
    func showActivityIndicator()
    func hideActivityIndicator()
}

public extension ActivityIndicatorPresenter where Self: UIViewController {
    
    func showActivityIndicator() {
        DispatchQueue.main.async {
            self.activityIndicator.style = .large
            self.activityIndicator.color = #colorLiteral(red: 0.3411764706, green: 0.3411764706, blue: 0.337254902, alpha: 1)
            self.activityIndicator.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
            self.activityIndicator.center = CGPoint(x: self.view.bounds.size.width / 2, y: self.view.bounds.height / 2)
            self.activityIndicator.accessibilityElementsHidden = true
            self.view.addSubview(self.activityIndicator)
            self.activityIndicator.startAnimating()
        }
    }
    
    func hideActivityIndicator() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.activityIndicator.removeFromSuperview()
        }
    }
}
