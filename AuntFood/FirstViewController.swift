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
        comboxView.bindData(list, comboxHelper: helper, seletedIndex: 1, comboxDelegate: self, containnerView: self.view)
    }
    
    func setupCombox2(){
        var helper = SWComboxCountryHelper()
        
        var country1 = SWCountry()
        country1.name = "China"
        country1.image = UIImage(named: "square-CN.png")
        
        var country2 = SWCountry()
        country2.name = "Japen"
        country2.image = UIImage(named: "square-JP.png")
        
        var country3 = SWCountry()
        country3.name = "America"
        country3.image = UIImage(named: "square-US.png")
        
        var list = [country1, country2, country3]
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
}

