//
//  loadingExtensions.swift
//  Payme
//
//  Created by Muraino Yakubu on 3/22/20.
//  Copyright © 2020 Muraino Yakubu. All rights reserved.
//

import UIKit


var vSpinner : UIView?
 
extension UIViewController {
    @available(iOS 13.0, *)
    func showSpinner(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: .large)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        vSpinner = spinnerView
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {
            vSpinner?.removeFromSuperview()
            vSpinner = nil
        }
    }
}
