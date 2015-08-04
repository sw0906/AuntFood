//
//  SWComboxCountryView.swift
//  AuntFood
//
//  Created by shouwei on 3/8/15.
//  Copyright (c) 2015 shou. All rights reserved.
//

import UIKit

class THCountry:NSObject {
    var name:String!
    var code:String = ""
}


class SWComboxCountry: UIView {
    
    @IBOutlet weak var icon: UIImageView!
    
    @IBOutlet weak var name: UILabel!
    
    func bindCountry(country: THCountry)
    {
        bindImage(country.code, title: country.name)
    }
    
    func bindImage(imageName:String, title: String)
    {
//        icon.image = UIImage.flagImageForCountry(imageName)
        name.text = title
    }
}
