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
    
    @IBOutlet var array: [UIImageView]!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        testNetwork()
        testFont()
        testImageArray()
        testProgress()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
    //MARK: test
    func testProgress() {
//        SVProgressHUD.showProgress(status: "loading", maskType: SVProgressHUDMaskType.Black)
        SVProgressHUD.showWithStatus("loading", maskType: SVProgressHUDMaskType.Black)
    }
    
    
    func testImageArray(){
        var cogIcon = FAKFontAwesome.cogIconWithSize(20)
        cogIcon.addAttribute(NSForegroundColorAttributeName, value: UIColor.blueColor())
        self.array[0].image = cogIcon.imageWithSize(CGSizeMake(50, 50))
        
        cogIcon = FAKFontAwesome.appleIconWithSize(20);
        self.array[1].image = cogIcon.imageWithSize(CGSizeMake(50, 50))
        
        cogIcon = FAKFontAwesome.cropIconWithSize(20);
        self.array[2].image = cogIcon.imageWithSize(CGSizeMake(50, 50))
        
        cogIcon = FAKFontAwesome.eyeIconWithSize(20);
        self.array[3].image = cogIcon.imageWithSize(CGSizeMake(40,40))
        
        
        var socIcon = FAKZocial.amazonIconWithSize(10)
        socIcon.addAttribute(NSForegroundColorAttributeName, value: UIColor.blueColor())
        self.array[4].image = socIcon.imageWithSize(CGSizeMake(40,40))
        
        socIcon = FAKZocial.gmailIconWithSize(10);
        self.array[5].image = socIcon.imageWithSize(CGSizeMake(40,40))
        
        socIcon = FAKZocial.googleplayIconWithSize(10);
        self.array[6].image = socIcon.imageWithSize(CGSizeMake(40,40))
        
        socIcon = FAKZocial.facebookIconWithSize(10);
        self.array[7].image = socIcon.imageWithSize(CGSizeMake(40,40))
        
    }
    
    func  testFont()
    {
        let cogIcon = FAKFontAwesome.cogIconWithSize(10)
        cogIcon.addAttribute(NSForegroundColorAttributeName, value: UIColor.blueColor())
        self.imageView.image = cogIcon.imageWithSize(CGSizeMake(20,20))
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

