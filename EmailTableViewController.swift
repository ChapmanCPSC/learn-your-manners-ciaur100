//
//  EmailTableViewController.swift
//  Manners
//
//  Created by Stephen Ciauri on 4/18/16.
//  Copyright © 2016 Stephen Ciauri. All rights reserved.
//

import UIKit

class EmailTableViewController: UITableViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBAction func doneTapped(sender: UIBarButtonItem) {
        let ud = NSUserDefaults.standardUserDefaults()
        
        if let address = emailTextField.text{
            ud.setObject(address, forKey: "email")
            ud.synchronize()
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        loadEmail()
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    private func loadEmail(){
        let ud = NSUserDefaults.standardUserDefaults()
        let email = ud.objectForKey("email") as? String
        emailTextField.text = email
    }
    
    @objc
    private func dismissKeyboard(){
        emailTextField.resignFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

}
