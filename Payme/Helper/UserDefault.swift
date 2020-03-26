//
//  UserDefault.swift
//  SchoolSystem
//
//  Created by Muraino Yakubu on 2/14/20.
//  Copyright © 2020 Muraino Yakubu. All rights reserved.
//

import Foundation


extension UserDefaults {
    func setLoggedIn(value: Bool) {
        set(value, forKey: "homeviewsegue")
        synchronize()
    }
    
    func isLoggedIn() -> Bool {
        return bool(forKey: "homeviewsegue")
    }
}
