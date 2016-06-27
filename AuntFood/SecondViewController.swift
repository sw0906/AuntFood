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

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        testNetwork()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
    //MARK: test
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

