//
//  ModelViewController.swift
//  Alculator
//
//  Created by Myles Scolnick on 11/1/14.
//  Copyright (c) 2014 Myles Scolnick. All rights reserved.
//

import UIKit


class ModelViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet var brewTableView: UITableView!
    
    var items: [Brew] = manager.brewArray
    var tempBrew:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.brewTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell = self.brewTableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell
        
        cell.textLabel.text = self.items[indexPath.row].brewName
        cell.detailTextLabel?.text = self.items[indexPath.row].brewery
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("You selected cell #\(indexPath.row)!")
        self.tempBrew = self.items[indexPath.row].brewName
    }
    
    @IBAction func closeModal(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
        println("Exit")
    }
    @IBAction func acceptBrew(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
        manager.currentBrew = self.tempBrew
        println("Exit and Save")
    }

}

