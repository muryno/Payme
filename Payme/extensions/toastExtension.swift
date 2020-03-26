//
//  toastExtension.swift
//  Payme
//
//  Created by Muraino Yakubu on 3/22/20.
//  Copyright © 2020 Muraino Yakubu. All rights reserved.
//

import UIKit


extension UIViewController {
  func showToast(message: String, seconds: Double) {
    let alert = UIAlertController(title: nil, message: message,
      preferredStyle: .alert)
    alert.view.backgroundColor = UIColor.black
    alert.view.alpha = 0.6
    alert.view.layer.cornerRadius = 15
    present(alert, animated: true)
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds)
    {alert.dismiss(animated: true)}
  }
}
