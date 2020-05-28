//
//  HomeTableViewCell.swift
//  Payme
//
//  Created by Muraino Yakubu on 5/27/20.
//  Copyright © 2020 Muraino Yakubu. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

  
    @IBOutlet weak var back_view: UIView!
    @IBOutlet weak var front_view: UIView!
    @IBOutlet weak var description_view: UILabel!
    @IBOutlet weak var dept_txt: UILabel!
    @IBOutlet weak var date_txt: UILabel!
    @IBOutlet weak var status_txt: UILabel!
    @IBOutlet weak var amount_txt: UILabel!
    
  
    var pendReq : Request? {
        
        didSet{
            self.UpDateUi()
        }
    }

    
    func UpDateUi(){
        
               back_view.layer.cornerRadius = 10.0;
      //  front_view.roundCorners([.topRight, .bottomRight], radius: 10)
        
        amount_txt?.text = pendReq?.amount
        date_txt?.text = pendReq?.date
        dept_txt?.text = pendReq?.department
        description_view?.text = pendReq?.request_description

    }
    
}

