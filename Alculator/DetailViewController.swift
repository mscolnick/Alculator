//
//  DetailViewController.swift
//  Alculator
//
//  Created by Myles Scolnick on 11/26/14.
//  Copyright (c) 2014 Myles Scolnick. All rights reserved.
//

import UIKit


class DetailViewController : UIViewController {
    
    @IBOutlet var brewNameLabel: UILabel!
    @IBOutlet var breweryLabel: UILabel!
    @IBOutlet var abvLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var catagoryLabel: UILabel!

    
    var brewDetail : Brew?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.brewNameLabel.text = brewDetail?.brewName
        self.breweryLabel.text = brewDetail?.brewery
        self.abvLabel.text = "\(brewDetail?.abv)"
        self.locationLabel.text = brewDetail?.location
        self.catagoryLabel.text = brewDetail?.category
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func backButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
        println("Left Detail")
    }
    
}
