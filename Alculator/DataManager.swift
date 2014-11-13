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

class DataManager {
    lazy var importer = DataImporter()
    var data = [String]()
    var brewDict = Dictionary<String, Float>()
    var currentBrew:String = ""
    
    init(){
        brewDict = ["Keystone": 0.4, "Coors": 0.4, "Bud": 0.5]
    }
}



let manager = DataManager()
