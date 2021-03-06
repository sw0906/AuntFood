//
//  FirstViewController.swift
//  AuntFood
//
//  Created by shouwei on 26/7/15.
//  Copyright (c) 2015 shou. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class FirstViewConvarller: UIViewController, SWComboxViewDelegate {
    
    
    @IBOutlet weak var comboxTest: UIView!
    
    @IBOutlet weak var comboxTest2: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //        setupCombox()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        setupCombox()
        setupCombox2()
        
//        testNetwork()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupCombox()
    {
        var helper: SWComboxTitleHelper
        helper = SWComboxTitleHelper()
        
        let list = ["good", "middle", "bad"]
        var comboxView:SWComboxView
        comboxView = SWComboxView.loadInstanceFromNibNamedToContainner(self.comboxTest)!
        comboxView.bindData(list, comboxHelper: helper, seletedIndex: 1, comboxDelegate: self, containnerView: self.view)
    }
    
    func setupCombox2(){
        let helper = SWComboxCountryHelper()
        
        let country1 = SWCountry()
        country1.name = "China"
        country1.image = UIImage(named: "square-CN.png")
        
        let country2 = SWCountry()
        country2.name = "Japen"
        country2.image = UIImage(named: "square-JP.png")
        
        let country3 = SWCountry()
        country3.name = "America"
        country3.image = UIImage(named: "square-US.png")
        
        let list = [country1, country2, country3]
        var comboxView:SWComboxView
        comboxView = SWComboxView.loadInstanceFromNibNamedToContainner(self.comboxTest2)!
        comboxView.bindData(list, comboxHelper: helper, seletedIndex: 1, comboxDelegate: self, containnerView: self.view)
    }
    
    
    
    //MARK: delegate
    func selectedAtIndex(index:Int, withCombox: SWComboxView)
    {
    }
    func tapComboxToOpenTable(combox: SWComboxView)
    {
        
    }
    
    
    //test
    func parseData(json: AnyObject)
    {
        let item = MovieItem()
        
        if let data = json.dataUsingEncoding(NSUTF8StringEncoding) {
            let json = JSON(data: data)
            
//            for item in json["people"].arrayValue {
//                print(item["firstName"].stringValue)
//            }
            item.Country = json["Country"].stringValue
            item.Genre = json["Genre"].stringValue
        }
    }
    
    
    func testNetwork(){
        let url = "https://www.omdbapi.com"
        let parameters = ["type" : "Movie", "t" : "old", "plot" : "short", "r" : "json" ];


        Alamofire.request(.GET, url, parameters: parameters)
            .validate()
            .responseJSON { response in
                
                
                print(response)
                
                
                switch response.result {
                case .Success:
                    self.parseData(response.result.value!)
                    print("Validation Successful")
                case .Failure(let error):
                    print(error)
                }
        }
        

    }
    
    
}

