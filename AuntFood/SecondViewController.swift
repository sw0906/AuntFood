//
//  SecondViewController.swift
//  AuntFood
//
//  Created by shouwei on 26/7/15.
//  Copyright (c) 2015 shou. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD
import ChameleonFramework
import MGSwipeTableCell
import FontAwesomeKit

class SecondViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        testNetwork()
        testFont()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
    //MARK: test
    func  testFont()
    {
        let cogIcon = FAKFontAwesome.cogIconWithSize(20)
        cogIcon.addAttribute(NSForegroundColorAttributeName, value: UIColor.blueColor())
        self.imageView.image = cogIcon.imageWithSize(CGSizeMake(20,20))
        cogIcon.iconFontSize = 15
    }
    
    func testNetwork(){
        Alamofire.request(.GET, "https://httpbin.org/get", parameters: ["foo": "bar"])
            .validate()
            .responseJSON { response in
                switch response.result {
                case .Success:
                    print("Validation Successful")
                case .Failure(let error):
                    print(error)
                }
        }
    }
}

