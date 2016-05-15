//
//  ResultViewController.swift
//  iQuiz
//
//  Created by apple on 5/13/16.
//  Copyright © 2016 apple. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet weak var results: UILabel!
    var points : Int = 0;
    var quizNum : Int = 0;
    override func viewDidLoad() {
        super.viewDidLoad()
        switch self.points {
        case self.quizNum:
            results.text = "Perfect! You got full score!"
        case 0:
            results.text = "Sorry, hope you could do better next time...";
        default:
            results.text = "Almost! You got " + String(self.points) + " out of " + String(self.quizNum);
        }
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
