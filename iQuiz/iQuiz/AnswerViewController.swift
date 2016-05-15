//
//  AnswerViewController.swift
//  iQuiz
//
//  Created by apple on 5/12/16.
//  Copyright © 2016 apple. All rights reserved.
//

import UIKit

class AnswerViewController: UIViewController {
    var userA : String = "";
    var qa : String = "";
    var points : Int = 0;
    var quizNum : Int = 0;
    var questionList = [];
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var userALabel: UILabel!
    @IBOutlet weak var next: UIButton!
    @IBOutlet weak var finished: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        NSLog(userA);
        NSLog(qa);
        if (userA == qa) {
            userALabel.text = "Congratulations you got this correct!";
            points = points + 1;
        } else {
            userALabel.text = "Sorry, " + userA +  " is not the correct answer";
        }

        answerLabel.text = qa;
        print(quizNum);
        print(self.questionList.count)
        if (self.quizNum == self.questionList.count - 1) {
            finished.enabled = true;
            next.enabled = false;
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "nextSegue") {
            let qView : QuizViewController = segue.destinationViewController as! QuizViewController;
            qView.points = points;
            qView.quizNum = quizNum + 1;
            qView.questionList = self.questionList;
            print(qView.quizNum);
            print(qView.points);
        } else {
            let qView : ResultViewController = segue.destinationViewController as! ResultViewController;
            qView.points = points;
            qView.quizNum = quizNum + 1;
            print(qView.quizNum);
            print(qView.points);
        }
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
