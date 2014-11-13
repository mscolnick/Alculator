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

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var containerX:CGFloat = 0
    var containerY:CGFloat = 0
    var containerWidth:CGFloat = 0
    var containerHeight:CGFloat = 0
    var arr:NSArray = []
    var brewDict = Dictionary<String, Float>()

    @IBOutlet var brewLabel: UILabel!
    @IBOutlet var pickerViewContainer: UIView!
    @IBOutlet var homeViewContainer: UIView!
    
    @IBOutlet var ouncesField: UITextField!
    @IBOutlet var beersField: UITextField!
    @IBOutlet var pricesField: UITextField!
    
    @IBOutlet var totalBuzzLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        brewDict = ["Keystone": 0.4, "Coors": 0.4, "Bud": 0.5]
        arr = Array(brewDict.keys)
        
        containerX = 0
        containerY = homeViewContainer.bounds.height
        containerWidth = homeViewContainer.bounds.width
        containerHeight = pickerViewContainer.bounds.height

        pickerViewContainer.frame = CGRectMake(containerX, containerY, containerWidth, containerHeight)

        pickerViewContainer.hidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return brewDict.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        brewLabel.text = "\(arr[row])"
        calculateBuzz()
        return "\(arr[row])"
    }
    
    
    @IBAction func showBrews(sender: AnyObject) {
        if(pickerViewContainer.hidden){
            pickerViewContainer.frame = CGRectMake(containerX, containerY, containerWidth, containerHeight)
            pickerViewContainer.hidden = false
        }
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(0.3)
        pickerViewContainer.frame = CGRectMake(containerX, containerY-containerHeight, containerWidth, containerHeight)
        UIView.commitAnimations()
        println("Show")
    }
    
    @IBAction func hideBrews(sender: AnyObject) {
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(0.3)
        pickerViewContainer.frame = CGRectMake(containerX, containerY, containerWidth, containerHeight)
        UIView.commitAnimations()
        println("Hide")
    }
    
    /**
    * Called when 'return' key pressed. return NO to ignore.
    */
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        pickerViewContainer.hidden = true
        calculateBuzz()
        return true
    }
    
    
    /**
    * Called when the user click on the view (outside the UITextField).
    */
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true)
        pickerViewContainer.hidden = true
        calculateBuzz()
    }
    
    
    func calculateBuzz(){
        if(brewLabel.text != nil && ouncesField.text.floatValue > 0 && beersField.text.floatValue > 0 && pricesField.text.floatValue > 0){
            var ounces:Float = ouncesField.text.floatValue
            var beers:Float = beersField.text.floatValue
            var price:Float = pricesField.text.floatValue
            totalBuzzLabel.text = NSString(format: "%.1f", brewDict[brewLabel.text!]!*ounces*beers/price)
        }
    }

}

