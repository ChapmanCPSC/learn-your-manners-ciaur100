//
//  TableViewController.swift
//  Manners
//
//  Created by Stephen Ciauri on 4/18/16.
//  Copyright © 2016 Stephen Ciauri. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    lazy var topics: [[String:AnyObject]] = self.loadTopicsFromDefaults()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadTopicsFromDefaults() -> [[String:AnyObject]]{
        let defaults = NSUserDefaults.standardUserDefaults()
        return defaults.objectForKey("topics") as! [[String:AnyObject]]
    }
    
    func saveToDefaults(){
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(topics, forKey: "topics")
        defaults.synchronize()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return topics.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("celly", forIndexPath: indexPath)
        
        cell.textLabel?.text = topics[indexPath.row]["title"] as? String
        cell.detailTextLabel?.text = topics[indexPath.row]["viewed"] as? Bool == true ? "✅" : ""
        

        // Configure the cell...

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // Brain defaulted to "Toggle" ... -_-"
//        if let viewed = topics[indexPath.row]["viewed"] as? Bool{
//            topics[indexPath.row]["viewed"] = !viewed
//        }else{
//            topics[indexPath.row]["viewed"] = true
//        }
        topics[indexPath.row]["viewed"] = true
        tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        saveToDefaults()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "topicDetail"{
            let dvc = segue.destinationViewController as! TopicViewController
            let topic = topics[tableView.indexPathForSelectedRow!.row]
            dvc.text = topic["article"] as? String
            dvc.imageName = topic["image"] as? String
            dvc.title = topic["title"] as? String
        }
    }


}
