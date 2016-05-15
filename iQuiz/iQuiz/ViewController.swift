//
//  ViewController.swift
//  iQuiz
//
//  Created by apple on 5/5/16.
//  Copyright © 2016 apple. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var selectedRow : Int = -1;
    var getUrl = "http://tednewardsandbox.site44.com/questions.json";
    @IBOutlet weak var tableView: UITableView!
    var tableViewData : [String] = ["Mathematics", "Marvel Super Heroes", "Science"];
    var tableViewDesc : [String] = ["", "", ""]
    var mathQ = [];
    var scienceQ = [];
    var marvelQ = [];
    var imageSource : [UIImage] = [UIImage(named: "math.jpg")!, UIImage(named: "marvel.jpeg")!, UIImage(named: "science.jpg")!];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        retrieveOffline("/Users/apple/code/info498/iQuizios/iQuiz/iQuiz/resources.json")
        retrieveOnline(getUrl)
    }
    
    private func retrieveOffline(getPath : String) {
        do {
            let data = try NSData(contentsOfFile: getPath, options: .DataReadingMappedIfSafe);
            let json = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
            if let jsonObject = (json as? NSArray){
                var i = 0;
                for quiz in jsonObject {
                    // each quiz is a dictionary
                    // print(quiz["title"]);
                    // print(quiz["desc"]);
                    let singleT = quiz["title"] as! String;
                    //print(singleT);
                    self.tableViewData[i] = singleT;
                    let singleD = quiz["desc"] as! String;
                    //print(singleD);
                    self.tableViewDesc[i] = singleD;
                    switch singleT {
                    case "Marvel Super Heroes":
                        self.marvelQ = quiz["questions"] as! [AnyObject]
                    //print(self.marvelQ);
                    case "Science!":
                        self.scienceQ = quiz["questions"] as! [AnyObject]
                    //print(self.scienceQ);
                    case "Mathematics":
                        self.mathQ = quiz["questions"] as! [AnyObject]
                    //print(self.mathQ);
                    default:
                        print("ERROR! didn't get questions for each quiz");
                    }
                    i = i+1;
                }
            }
        } catch {
            print(error)
            print("ERROR! didn't retrieve data offline")
        }
        
    }
    
    private func retrieveOnline(getUrl : String) {
        let requestURL: NSURL = NSURL(string: getUrl)!
        let urlRequest: NSMutableURLRequest = NSMutableURLRequest(URL: requestURL)
        httpGet(urlRequest) { (data, error) -> Void in
            if error != nil {
                print("httpGet error:")
                print(error)
            } else {
                print(data)
                let rawData = data.dataUsingEncoding(NSUTF8StringEncoding);
                print(rawData);
                //let saved = try NSJSONSerialization.JSONObjectWithData(rawData!, options: .AllowFragments)
                let fileM = NSFileManager.defaultManager();
                fileM.createFileAtPath("/Users/apple/code/info498/iQuizios/iQuiz/iQuiz/resources.json", contents: rawData, attributes: nil);
                do{
                    let json = try NSJSONSerialization.JSONObjectWithData(rawData!, options: .AllowFragments)
                    if let jsonObject = (json as? NSArray){
                        var i = 0;
                        for quiz in jsonObject {
                            // each quiz is a dictionary
                            // print(quiz["title"]);
                            // print(quiz["desc"]);
                            let singleT = quiz["title"] as! String;
                            //print(singleT);
                            self.tableViewData[i] = singleT;
                            let singleD = quiz["desc"] as! String;
                            //print(singleD);
                            self.tableViewDesc[i] = singleD;
                            switch singleT {
                            case "Marvel Super Heroes":
                                self.marvelQ = quiz["questions"] as! [AnyObject]
                            //print(self.marvelQ);
                            case "Science!":
                                self.scienceQ = quiz["questions"] as! [AnyObject]
                            //print(self.scienceQ);
                            case "Mathematics":
                                self.mathQ = quiz["questions"] as! [AnyObject]
                            //print(self.mathQ);
                            default:
                                print("ERROR! didn't get questions for each quiz");
                            }
                            i = i+1;
                        }
                    }
                    
                    
                }catch {
                    print("Error with Json: \(error)")
                }
            }
        }
    }
    
    func httpGet(request: NSURLRequest!, callback: (String, String?) -> Void) {
        let session = NSURLSession.sharedSession();
        let task = session.dataTaskWithRequest(request) {
            (data, response, error) -> Void in if error != nil {
                callback("", error!.localizedDescription)
            } else {
                let result = NSString(data: data!, encoding: NSASCIIStringEncoding)!;
                callback(result as String, nil)
            }
        }
        task.resume()
    }
    
    @IBAction func pressed(sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Settings", message: "Update JSON file", preferredStyle: UIAlertControllerStyle.Alert);
        
        let confirmAction = UIAlertAction(title: "Check Now", style: .Default) { (_) in
            if let field = alert.textFields![0] as? UITextField {
                // store your data
                self.getUrl = field.text!;
                print("self.getUrl is updated to " + self.getUrl)
//                    UIApplication.sharedApplication().keyWindow?.rootViewController = self.storyboard!.instantiateViewControllerWithIdentifier("Root_View")
                self.retrieveOnline(self.getUrl)
            } else {
                // user did not fill field
                self.getUrl = "http://tednewardsandbox.site44.com/questions.json"
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in }
        alert.addTextFieldWithConfigurationHandler { (textField) in
            textField.text = "http://tednewardsandbox.site44.com/questions.json"
        }
        alert.addAction(confirmAction)
        alert.addAction(cancelAction)
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
        print(tableViewData)
        cell.textLabel?.text = tableViewData[indexPath.row]
        print(tableViewDesc);
        cell.detailTextLabel?.text = tableViewDesc[indexPath.row]
        print("indexPath.row: " + String(indexPath.row))
        let image = imageSource[indexPath.row]
        cell.imageView?.image = image;
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedRow = indexPath.row;
        let quizView : QuizViewController = storyboard?.instantiateViewControllerWithIdentifier("quiz") as! QuizViewController;
        switch selectedRow {
        case 0:
            quizView.questionList = scienceQ
        case 1:
            quizView.questionList = marvelQ
        case 2:
            quizView.questionList = mathQ
        default:
            print("questionList not being passed successfully")
        }
        quizView.quizNum = 0;
        self.navigationController?.pushViewController(quizView, animated: true);
    }

}

