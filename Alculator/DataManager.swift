//
//  DataManager.swift
//  Alculator
//
//  Created by Myles Scolnick on 11/13/14.
//  Copyright (c) 2014 Myles Scolnick. All rights reserved.
//

import Foundation

class DataImporter {
    var fileName = "data.txt"
}


struct Brew {
    var brewery = ""
    var brewName = ""
    var location = ""
    var abv:Float = 0.0
}

class DataManager {
    lazy var importer = DataImporter()
    var data = [String]()
    var brewDict = Dictionary<String, Float>()
    var brewArray: [Brew] = []
    var currentBrew:String = ""
    var rows: [Dictionary<String, String>] = []
    
    init(){

        var csvURL = NSURL.fileURLWithPath(NSBundle.mainBundle().pathForResource("abv", ofType: "csv")!)
        var error: NSErrorPointer = nil
        
        var csv = CSV(contentsOfURL: csvURL!, error: error)
        self.rows = csv.getRows()
        for row in self.rows{
            var beerName:String = row["Beer"]!
            var brewery:String = row["Brewery"]!
            var beerABV:Float = row["ABV"]!.floatValue
            var location:String = row["Location"]!
            brewDict[beerName] = beerABV
            brewArray.append(Brew(brewery: brewery, brewName: beerName, location: location, abv: beerABV))
        }
    
    }
}



let manager = DataManager()