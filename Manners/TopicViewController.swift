//
//  TopicViewController.swift
//  Manners
//
//  Created by Stephen Ciauri on 4/18/16.
//  Copyright © 2016 Stephen Ciauri. All rights reserved.
//

import UIKit

class TopicViewController: UIViewController {

    var topic: Topic?
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = UIImage(named: topic!.imageName)
        textView.text = topic?.article

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
