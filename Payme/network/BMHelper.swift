//
//  BMHelper.swift
//  SchoolSystem
//
//  Created by Muraino Yakubu on 1/29/20.
//  Copyright © 2020 Muraino Yakubu. All rights reserved.
//

import UIKit

class VC:UIViewController {
    deinit {
        print("deinit \(#function)")
    }
}

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}
