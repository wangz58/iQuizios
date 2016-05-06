//
//  ViewController.swift
//  iQuiz
//
//  Created by apple on 5/5/16.
//  Copyright © 2016 apple. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var tableViewData : [String] = ["Mathematics", "Marvel Super Heroes", "Science"];
    var tableViewDesc : [String] = ["This is a math test", "This is a test about Marvel Heroes", "This is a test about science"]
    var imageSource : [UIImage] = [UIImage(contentsOfFile: "/Users/apple/code/info498/iQuizios/iQuiz/images/math.jpg")!, UIImage(contentsOfFile: "/Users/apple/code/info498/iQuizios/iQuiz/images/marvel.jpeg")!, UIImage(contentsOfFile: "/Users/apple/code/info498/iQuizios/iQuiz/images/science.jpg")!];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
//        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell");
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBAction func pressed(sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Alert", message: "Settings Goes Here", preferredStyle: UIAlertControllerStyle.Alert);
        alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil));
        self.presentViewController(alert, animated: true, completion: nil);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
        
        cell.textLabel?.text = tableViewData[indexPath.row]
        cell.detailTextLabel?.text = tableViewDesc[indexPath.row]
        
        let image = imageSource[indexPath.row]
        cell.imageView?.image = image;
        
        return cell
    }
    
//    func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
//        return tableViewDesc[section];
//    }
//    
//    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return tableViewData[section];
//    }

}

