//
//  TableViewController.swift
//  Manners
//
//  Created by Stephen Ciauri on 4/18/16.
//  Copyright © 2016 Stephen Ciauri. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    lazy var topics: [Topic] = self.loadTopicObjectsFromDisk()

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
    
    func loadTopicObjectsFromDisk() -> [Topic]{
        let defaults = NSUserDefaults.standardUserDefaults()
        let data = defaults.objectForKey("topicObjects") as! NSData
        return NSKeyedUnarchiver.unarchiveObjectWithData(data) as! [Topic]
    }
    
    func saveToDefaults(){
        let defaults = NSUserDefaults.standardUserDefaults()
        let data = NSKeyedArchiver.archivedDataWithRootObject(topics)
        defaults.setObject(data, forKey: "topicObjects")
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
        
        cell.textLabel?.text = topics[indexPath.row].title
        cell.detailTextLabel?.text = topics[indexPath.row].viewed ? "✅" : ""
        

        // Configure the cell...

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        topics[indexPath.row].viewed = true
        tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        saveToDefaults()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "topicDetail"{
            let dvc = segue.destinationViewController as! TopicViewController
            let topic = topics[tableView.indexPathForSelectedRow!.row]
            dvc.topic = topic
            dvc.title = topic.title
            
        }
    }


}
