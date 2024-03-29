//
//  TestFieldExtentions.swift
//  Payme
//
//  Created by Muraino Yakubu on 3/10/20.
//  Copyright © 2020 Muraino Yakubu. All rights reserved.
//

import UIKit


extension UITextField {
  func setLeftView(image: UIImage) {
    let iconView = UIImageView(frame: CGRect(x: 10, y: 10, width: 20, height: 20)) // set your Own size
    iconView.image = image
    let iconContainerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: 45))
    iconContainerView.addSubview(iconView)
    leftView = iconContainerView
    leftViewMode = .always
    self.tintColor = .lightGray
  }
}
