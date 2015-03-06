//
//  ViewController.swift
//  Alculator
//
//  Created by Myles Scolnick on 11/1/14.
//  Copyright (c) 2014 Myles Scolnick. All rights reserved.
//

import UIKit

extension String {
    var floatValue: Float {
        return (self as NSString).floatValue
    }
}

class ViewController: UIViewController {
    

    @IBOutlet var brewLabel: UILabel!
    
    @IBOutlet var ouncesField: UITextField!
    @IBOutlet var beersField: UITextField!
    @IBOutlet var pricesField: UITextField!
    
    @IBOutlet var totalBuzzLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewDidAppear(animated: Bool) {
        brewLabel.text = manager.currentBrew
        calculateBuzz()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**
    * Called when 'return' key pressed. return NO to ignore.
    */
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        calculateBuzz()
        return true
    }
    
    
    /**
    * Called when the user click on the view (outside the UITextField).
    */
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true)
        calculateBuzz()
    }
    
    
    func calculateBuzz(){
        if(manager.currentBrew != "" && ouncesField.text.floatValue > 0 && beersField.text.floatValue > 0 && pricesField.text.floatValue > 0){
            var ounces:Float = ouncesField.text.floatValue
            var beers:Float = beersField.text.floatValue
            var price:Float = pricesField.text.floatValue
            var abv:Float = manager.brewDict[brewLabel.text!]!
            totalBuzzLabel.text = NSString(format: "%.1f", abv*ounces*beers/price)
        }
    }
}

