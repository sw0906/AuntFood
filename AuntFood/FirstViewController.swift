//
//  FirstViewController.swift
//  AuntFood
//
//  Created by shouwei on 26/7/15.
//  Copyright (c) 2015 shou. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, SWComboxViewDelegate {
    
    
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
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupCombox()
    {
        var helper: SWComboxTitleHelper
        helper = SWComboxTitleHelper()
        
        var list = ["good", "middle", "bad"]
        var comboxView:SWComboxView
        comboxView = SWComboxView.loadInstanceFromNibNamedToContainner(self.comboxTest)!
        comboxView.bindData(list, comboxHelper: helper, seletedIndex: 1, comboxDelegate:self)
    }
    
    func setupCombox2(){
        var helper = SWComboxCountryHelper()
        
        var country1 = THCountry()
        country1.name = "China"
        var country2 = THCountry()
        country2.name = "Japen"
        var country3 = THCountry()
        country3.name = "America"
        
        var list = [country1, country2, country3]
        var comboxView:SWComboxView
        comboxView = SWComboxView.loadInstanceFromNibNamedToContainner(self.comboxTest2)!
        comboxView.bindData(list, comboxHelper: helper, seletedIndex: 0, comboxDelegate: self)
    }
    
    
    
    //MARK: delegate
    func selectedAtIndex(index:Int, withCombox: SWComboxView)
    {
    }
    func tapComboxToOpenTable(combox: SWComboxView)
    {}
}

