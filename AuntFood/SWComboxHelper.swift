//
//  SWComboxTitleHelper.swift
//  AuntFood
//
//  Created by shouwei on 3/8/15.
//  Copyright (c) 2015 shou. All rights reserved.
//

import UIKit

class SWComboxCommonHelper : NSObject {
    
    func loadCurrentView(contentView:UIView, data: AnyObject)
    {
        
    }
    
    func setCurrentView(data: AnyObject){
    }

    func getCurrentCell(tableView: UITableView, data: AnyObject) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func getCurrentTitle() -> String
    {
        return ""
    }
    
}



class SWComboxTitleHelper: SWComboxCommonHelper {
    
    var comboxView:SWComboxTitle!
    
    override func loadCurrentView(contentView:UIView, data: AnyObject)
    {
        comboxView = UIView.loadInstanceFromNibNamedToContainner(contentView)
        comboxView.bindTitle(data)
    }
    
    override func setCurrentView(data: AnyObject){
        comboxView.bindTitle(data)
    }
    
    override func getCurrentCell(tableView: UITableView, data: AnyObject) -> UITableViewCell {
        var cellFrame = comboxView.frame
        cellFrame.size.width = tableView.frame.size.width
        
        var cell = UITableViewCell()
        cell.frame = cellFrame
        
        var comboxV : SWComboxTitle
        comboxV = UIView.loadInstanceFromNibNamedToContainner(cell)!
        comboxV.bindTitle(data)
        return cell
    }
    
    override func getCurrentTitle() -> String {
        return self.comboxView.name.text!
    }
    
}

class SWComboxCountryHelper: SWComboxCommonHelper {
    
    var comboxView:SWComboxCountry!
    
    override func loadCurrentView(contentView:UIView, data: AnyObject)
    {
        comboxView = UIView.loadInstanceFromNibNamedToContainner(contentView)
        comboxView.bindCountry(data as! THCountry)
    }
    
    override func setCurrentView(data: AnyObject){
        comboxView.bindCountry(data as! THCountry)
    }
    
    override func getCurrentCell(tableView: UITableView, data: AnyObject) -> UITableViewCell {
        var cellFrame = comboxView.frame
        cellFrame.size.width = tableView.frame.size.width
        
        var cell = UITableViewCell()
        cell.frame = cellFrame
        
        var comboxV : SWComboxCountry
        comboxV = UIView.loadInstanceFromNibNamedToContainner(cell)!
        comboxV.bindCountry(data as! THCountry)
        return cell
    }
    
    override func getCurrentTitle() -> String {
        return self.comboxView.name.text!
    }
}





