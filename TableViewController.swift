//
//  TableViewController.swift
//  Manners
//
//  Created by Stephen Ciauri on 4/18/16.
//  Copyright © 2016 Stephen Ciauri. All rights reserved.
//

import UIKit
import MessageUI

class TableViewController: UITableViewController, MFMailComposeViewControllerDelegate {
    lazy var topics: [Topic] = self.loadTopicObjectsFromDisk()
    lazy var summaryButton: UIButton = self.createSummaryButton()
    private var composeMailVC: MFMailComposeViewController{
        get{
            let mcvc = MFMailComposeViewController()
            mcvc.mailComposeDelegate = self
            return mcvc
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        showSummaryButton()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        summaryButton.removeFromSuperview()
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
    
    func createSummaryButton() -> UIButton{
        let button = UIButton(type: .Custom)
        button.addTarget(self, action: #selector(sendSummaryEmail), forControlEvents: .TouchUpInside)
        button.backgroundColor = UIColor.orangeColor()
        button.setTitle("Send Summary", forState: .Normal)
        button.titleLabel?.textColor = UIColor.lightTextColor()
        
        return button
    }
    
    func showSummaryButton(){
        summaryButton.translatesAutoresizingMaskIntoConstraints = false
        view.window!.addSubview(summaryButton)
        let centerX = summaryButton.centerXAnchor.constraintEqualToAnchor(view.window!.centerXAnchor)
        let width = summaryButton.widthAnchor.constraintEqualToAnchor(view.window!.widthAnchor, constant: -16)
        let height = summaryButton.heightAnchor.constraintEqualToAnchor(view.window!.heightAnchor, multiplier: 0.1)
        let bottom = summaryButton.bottomAnchor.constraintEqualToAnchor(view.window!.bottomAnchor, constant: -8)
        NSLayoutConstraint.activateConstraints([centerX, width, height, bottom])
        
        summaryButton.alpha = 0
        
        UIView.animateWithDuration(0.2, animations: {
            self.summaryButton.alpha = 1
        })
    }
    
    func removeSummaryButton(){
        UIView.animateWithDuration(0.2,
                                   animations: {
                                    self.summaryButton.alpha = 0
            },
                                   completion: { _ in
                                    self.summaryButton.removeFromSuperview()
        })
    }
    
    func sendSummaryEmail(){
        let defaults = NSUserDefaults.standardUserDefaults()
        if let address = defaults.objectForKey("email") as? String where !address.isEmpty{
            var messageBody = "So far, you have viewed the following topics: \n"
            for topic in topics where topic.viewed == true{
                messageBody += "- \(topic.title)\n"
            }
            let cmvc = composeMailVC
            cmvc.setToRecipients([address])
            cmvc.setSubject("Summary of Manners")
            cmvc.setMessageBody(messageBody, isHTML: false)
            
            if MFMailComposeViewController.canSendMail(){
                presentViewController(cmvc, animated: true, completion: nil)
            }else{
                navigationItem.prompt = "Unable to send email"
            }
        }else{
            navigationItem.prompt = "Email address for summary not set"
        }
        
        NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: #selector(clearNavPrompt), userInfo: nil, repeats: false)
        
    }
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @objc
    private func clearNavPrompt(){
        navigationItem.prompt = nil
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
