//
//  ViewController.swift
//  Quizzy
//
//  Created by Eoin Molloy on 26/12/2015.
//  Copyright © 2015 Eoin Molloy. All rights reserved.
//

import UIKit
import Social

struct Question {
    var question : String!
    var answers : [String]!
    var answer : Int!
}

class ViewController: UIViewController {
    
    @IBOutlet weak var Label: UILabel!
    @IBOutlet var buttons: [UIButton]!
    
    @IBAction func tweetButton(sender: AnyObject) {
        
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter){
            let tweetController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            tweetController.setInitialText("I scored \(highScore) in Quizzy, can you beat me ?")
            
            self.presentViewController(tweetController, animated: true, completion: nil)
        }
        else {
            let alert  = UIAlertController(title: "Accounts", message: "You are not logged in to a twitter account, please login", preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            alert.addAction(UIAlertAction(title: "Settings", style: UIAlertActionStyle.Default, handler: {
                
                (UIAlertAction) in
            let URLSettings = NSURL(string: UIApplicationOpenSettingsURLString)
            
                if let url = URLSettings {
                    UIApplication.sharedApplication().openURL(url)
                }
            
            
            }))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    @IBOutlet weak var Score: UILabel!
    
    @IBOutlet weak var Highscore: UILabel!
    
    var Questions = [Question]()
    var questionNumber = Int()
    var answerNumber = Int()
    var scoreNum = 0
    var highScore = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        Questions = [Question(question: "Euro 2016 winner ?", answers: ["Ireland", "Ireland", "Ireland", "Ireland"], answer: 0),
        Question(question: "Wimbeldon Champion 2015?", answers: ["Andy Murray", "Novac Djokovic", "Pavel Nedved", "Roger Federer"], answer: 1),
        Question(question: "What team has won the most Superbowls ?", answers: ["New York Giants", "Pittsburgh Steelers", "New England Patriots", "Green Bay Packers"], answer: 1),
        Question(question: "Who was the last defender to win the Ballon d'or ?", answers: ["John O'Shea", "Gary Neville", "John Terry", "Fabio Cannavaro"], answer: 3),
        Question(question: "Youngest Champion in UFC history ?", answers: ["Conor McGregor", "Jon Jones", "Jose Aldo", "Ronda Rousey"], answer: 1),
        Question(question: "All-Time top goalscorer in the Champions League?", answers: ["Lionel Messi", "Cristiano Ronaldo", "Raul", "Ruud Van Nistelrooy"], answer: 1),
        Question(question: "Most own goals in Premier League history?", answers: ["Yaya Toure", "Richard Dunne", "Jamie Carragher", "Frank Lampard"], answer: 1),
        Question(question: "Most Olympic gold medals for a single person?", answers: ["Michael Phelps", "Usain Bolt", "Katie Taylor", "Chris Hoy"], answer: 0),
        Question(question: "Where is Superbowl 50 being held ?", answers: ["San Francisco", "New Jersey", "Chicago", "Denver"], answer: 0),
        Question(question: "Current Fifa World cup champions ?", answers: ["Ireland", "Ireland", "Ireland", "Ireland"], answer: 0),
        Question(question: "All-Ireland 2015 hurling Champions ?", answers: ["Ireland", "Ireland", "Ireland", "Ireland"], answer: 0),
        Question(question: "Muhammad Ali's boxing record ?", answers: ["Ireland", "Ireland", "Ireland", "Ireland"], answer: 0),
        Question(question: "Winner of First superbowl in 1967 ?", answers: ["Ireland", "Ireland", "Ireland", "Ireland"], answer: 0),
        Question(question: "Republic of Ireland All_time top Goalscorer?", answers: ["Ireland", "Ireland", "Ireland", "Ireland"], answer: 0),
        Question(question: "Most Passing yards in NFL history ?", answers: ["Ireland", "Ireland", "Ireland", "Ireland"], answer: 0),
        Question(question: "Team with most Soccar European club tiles(Champions league)?", answers: ["Ireland", "Ireland", "Ireland", "Ireland"], answer: 0),
        Question(question: "100 meter Sprint World Record holder ?", answers: ["Ireland", "Ireland", "Ireland", "Ireland"], answer: 0),
        Question(question: "In what year was the Rugby Football Union formed in London?", answers: ["Ireland", "Ireland", "Ireland", "Ireland"], answer: 0),
        Question(question: "In what year were women first allowed to participate in the Olympic games?", answers: ["Ireland", "Ireland", "Ireland", "Ireland"], answer: 0),
        Question(question: "What is the Highest capacity football stadium in England?", answers: ["Ireland", "Ireland", "Ireland", "Ireland"], answer: 0),
        Question(question: "Which is the only country to have played in each and every World Cup?", answers: ["Ireland", "Ireland", "Ireland", "Ireland"], answer: 0),
        Question(question: "Which was the first African country to qualify for a World Cup?", answers: ["Ireland", "Ireland", "Ireland", "Ireland"], answer: 0),
        Question(question: "What is the maximum time limit allowed to look for a lost ball in golf?", answers: ["Ireland", "Ireland", "Ireland", "Ireland"], answer: 0),
        Question(question: "Which sport did George Washington play with his troops?", answers: ["Ireland", "Ireland", "Ireland", "Ireland"], answer: 0),
        Question(question: "What is the highest possible break in snooker?", answers: ["Ireland", "Ireland", "Ireland", "Ireland"], answer: 0),
        Question(question: "Which boxer was an underdog with odds of 42:1 when he stunned Mike Tyson?", answers: ["Ireland", "Ireland", "Ireland", "Ireland"], answer: 0),
        Question(question: "How many red balls are used in a game of snooker?", answers: ["Ireland", "Ireland", "Ireland", "Ireland"], answer: 0),
        Question(question: "In motor racing, which flag is waved to show the winner?", answers: ["Ireland", "Ireland", "Ireland", "Ireland"], answer: 0),
        Question(question: "Who scored the winning penalty in the 2006 world cup final?", answers: ["Ireland", "Ireland", "Ireland", "Ireland"], answer: 0),
        Question(question: "How many players are there in an ice hockey team?", answers: ["Ireland", "Ireland", "Ireland", "Ireland"], answer: 0),
        Question(question: "What is the flat rubber disc known as in ice hockey?", answers: ["Ireland", "Ireland", "Ireland", "Ireland"], answer: 0),
        Question(question: "In which sport is the Davis cup awarded?", answers: ["Ireland", "Ireland", "Ireland", "Ireland"], answer: 0),
        Question(question: "In which sport is the Stanley cup awarded?", answers: ["Ireland", "Ireland", "Ireland", "Ireland"], answer: 0),
        Question(question: "Where was the FIFA World Cup held in 1986?", answers: ["Ireland", "Ireland", "Ireland", "Ireland"], answer: 0),
        Question(question: "In which Olympic sport is the wearing of a beard prohibited?", answers: ["Ireland", "Ireland", "Ireland", "Ireland"], answer: 0),
        Question(question: "How many periods is an ice hockey game divided into?", answers: ["Ireland", "Ireland", "Ireland", "Ireland"], answer: 0),
        Question(question: "What is the most valuable piece in a game of chess?", answers: ["Ireland", "Ireland", "Ireland", "Ireland"], answer: 0),
        Question(question: "Which country did Baseball originate from?", answers: ["Ireland", "Ireland", "Ireland", "Ireland"], answer: 0),
        Question(question: "Venus Williams is a famous name in which sport?", answers: ["Ireland", "Ireland", "Ireland", "Ireland"], answer: 0),
        Question(question: "Which British city is home to Everton Football Club?", answers: ["Ireland", "Ireland", "Ireland", "Ireland"], answer: 0),
        Question(question: "Which number is located between 15 and 17 on a standard dartboard?", answers: ["Ireland", "Ireland", "Ireland", "Ireland"], answer: 0),
        Question(question: "Which country won the FIFA World Cup in the years of 1994 and 2002?", answers: ["Ireland", "Ireland", "Ireland", "Ireland"], answer: 0),
        Question(question: "In golf, what is a hole completed in one under par called?", answers: ["Ireland", "Ireland", "Ireland", "Ireland"], answer: 0),
        Question(question: "In darts, how many points do you get if you hit a bullseye?", answers: ["Ireland", "Ireland", "Ireland", "Ireland"], answer: 0),
        Question(question: "Craven Cottage has been the football stadium since 1896 for which London based team?", answers: ["Ireland", "Ireland", "Ireland", "Ireland"], answer: 0),
        Question(question: "In football, in the Premiership, out of 20 teams how many are relegated each season?", answers: ["Ireland", "Ireland", "Ireland", "Ireland"], answer: 0),
        Question(question: "In snooker, which colour ball is potted last to complete the frame?", answers: ["Ireland", "Ireland", "Ireland", "Ireland"], answer: 0),
        Question(question: "Who scored the winning goal in the 2014 World Cup?", answers: ["Ireland", "Ireland", "Ireland", "Ireland"], answer: 0),
        Question(question: "How many points is a saftey worth in American football?", answers: ["Ireland", "Ireland", "Ireland", "Ireland"], answer: 0),]
        
        
        var HighscoreDefault = NSUserDefaults.standardUserDefaults()
        if HighscoreDefault.valueForKey("Highscore") != nil {
            highScore = HighscoreDefault.valueForKey("Highscore") as! NSInteger
            Highscore.text = NSString(format: "Highscore: %i", highScore) as String
        }
        RandomQuestion()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func RandomQuestion(){
        if Questions.count > 0{
            questionNumber = random() % Questions.count
            Label.text = Questions[questionNumber].question
            answerNumber = Questions[questionNumber].answer
            
            for i in 0..<buttons.count{
                buttons[i].setTitle(Questions[questionNumber].answers[i], forState: UIControlState.Normal)
            }
            Score.text = NSString(format: "Score: %i", scoreNum) as String
            Highscore.text = NSString(format: "Highscore: %i", highScore) as String

            if scoreNum > highScore{
                highScore = scoreNum
                Highscore.text = NSString(format: "Highscore: %i", highScore) as String
                
                var HighscoreDefault = NSUserDefaults.standardUserDefaults()
                HighscoreDefault.setValue(highScore, forKey: "Highscore")
                HighscoreDefault.synchronize()
            }
            //This will remove the question from the array but due to the small number I feel better that they can repeat
            //Questions.removeAtIndex(questionNumber)
        }
        
        else {
                NSLog("done")
        }
    }
    
    
    @IBAction func button1(sender: AnyObject) {
        if answerNumber == 0 {
            scoreNum++
            RandomQuestion()
        }
        
        else {
            scoreNum = 0
            RandomQuestion()
        }
        
    }

    @IBAction func button2(sender: AnyObject) {
        if answerNumber == 1 {
            scoreNum++

            RandomQuestion()
        }
            
        else {
            scoreNum = 0
            RandomQuestion()
        }

        
    }
    
    @IBAction func button3(sender: AnyObject) {
        if answerNumber == 2 {
            scoreNum++

            RandomQuestion()
        }
            
        else {
            scoreNum = 0
            RandomQuestion()
        }

    }
    
    @IBAction func button4(sender: AnyObject) {
        if answerNumber == 3 {
            scoreNum++

            RandomQuestion()
        }
            
        else {
            scoreNum = 0
            RandomQuestion()
        }

    }
    
    
    
}

