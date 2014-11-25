//
//  ModelViewController.swift
//  Alculator
//
//  Created by Myles Scolnick on 11/1/14.
//  Copyright (c) 2014 Myles Scolnick. All rights reserved.
//

import UIKit


class ModelViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchDisplayDelegate {
    
    
    @IBOutlet var brewTableView: UITableView!
    
    var items: [Brew] = manager.brewArray
    var tempBrew:String = ""
    var filteredBrews = [Brew]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.brewTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.searchDisplayController!.searchResultsTableView {
            return self.filteredBrews.count
        } else {
            return self.items.count;
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //ask for a reusable cell from the tableview, the tableview will create a new one if it doesn't have any
        var cell:UITableViewCell = self.brewTableView.dequeueReusableCellWithIdentifier("Cell") as UITableViewCell
        
        var brew : Brew
        // Check to see whether the normal table or search results table is being displayed and set the Candy object from the appropriate array
        if tableView == self.searchDisplayController!.searchResultsTableView {
            brew = filteredBrews[indexPath.row]
        } else {
            brew = items[indexPath.row]
        }
        
        // Configure the cell
        cell.textLabel.text = brew.brewName
        cell.detailTextLabel?.text = brew.brewery
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("You selected cell #\(indexPath.row)!")
        self.tempBrew = self.items[indexPath.row].brewName
        self.performSegueWithIdentifier("brewDetail", sender: tableView)

    }
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        // Filter the array using the filter method
        self.filteredBrews = self.items.filter({( brew: Brew) -> Bool in
            let categoryMatch = (scope == "All") || (brew.category == scope)
            let nameMatch = brew.brewName.rangeOfString(searchText)
            let breweryMatch = brew.brewery.rangeOfString(searchText)
            return categoryMatch && ((nameMatch != nil) || (breweryMatch != nil))
        })
    }
    
    func searchDisplayController(controller: UISearchDisplayController!, shouldReloadTableForSearchString searchString: String!) -> Bool {
        let scopes = self.searchDisplayController!.searchBar.scopeButtonTitles as [String]
        let selectedScope = scopes[self.searchDisplayController!.searchBar.selectedScopeButtonIndex] as String
        self.filterContentForSearchText(searchString, scope: selectedScope)
        return true
    }
    
    func searchDisplayController(controller: UISearchDisplayController!, shouldReloadTableForSearchScope searchOption: Int) -> Bool {
        let scope = self.searchDisplayController!.searchBar.scopeButtonTitles as [String]
        self.filterContentForSearchText(self.searchDisplayController!.searchBar.text, scope: scope[searchOption])
        return true
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "brewDetail" {
            let brewDetailViewController = segue.destinationViewController as UIViewController
            if sender as UITableView == self.searchDisplayController!.searchResultsTableView {
                let indexPath = self.searchDisplayController!.searchResultsTableView.indexPathForSelectedRow()!
                let destinationTitle = self.filteredBrews[indexPath.row].brewName
                brewDetailViewController.title = destinationTitle
            } else {
                let indexPath = self.brewTableView.indexPathForSelectedRow()!
                let destinationTitle = self.items[indexPath.row].brewName
                brewDetailViewController.title = destinationTitle
            }
        }
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

