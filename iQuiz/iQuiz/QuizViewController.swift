//
//  QuizViewController.swift
//  iQuiz
//
//  Created by apple on 5/13/16.
//  Copyright © 2016 apple. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var quizTitle: UILabel!
    var quizNum : Int = 0;
    var userAnswer : String = "";
    var questionList = [];
    var questions : [String] = [];
    var answers : [[AnyObject]] = [];
    var correctAnswer : [String] = [];
    var points : Int = 0;
    
    override func viewDidLoad() {
        self.pickerView.dataSource = self;
        self.pickerView.delegate = self;
        super.viewDidLoad()
            for question in questionList {
                let answer = question["answer"] as! String;
                correctAnswer.append(answer);
                print(correctAnswer)
                let options = question["answers"] as! [AnyObject];
                answers.append(options);
                print(answers)
                let quesTitle = question["text"] as! String;
                questions.append(quesTitle);
                print(questions)
            }
            quizTitle.text = questions[quizNum];
            let ua = answers[quizNum] as NSArray;
            let uas = ua[0] as! String;
            userAnswer = uas;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let ua = answers[quizNum] as NSArray;
        let uas = ua[row] as! String;
        userAnswer = uas;
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        let qn = answers[quizNum] as NSArray;
        let qrn = qn.count;
        return qrn;
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let ua = answers[quizNum] as NSArray;
        let uas = ua[row] as! String;
        return uas;
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let answerView : AnswerViewController = segue.destinationViewController as! AnswerViewController;
        answerView.userA = userAnswer;
        let thisAnswer = Int(correctAnswer[quizNum]);
        let thisQuiz = answers[quizNum] as NSArray;
        let thisQuizAnswer = thisQuiz[thisAnswer! - 1] as! String;
        answerView.qa = thisQuizAnswer;
        answerView.points = points;
        answerView.quizNum = quizNum;
        answerView.questionList = self.questionList;
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
