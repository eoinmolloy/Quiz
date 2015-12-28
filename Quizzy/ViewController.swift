//
//  ViewController.swift
//  Quizzy
//
//  Created by Eoin Molloy on 26/12/2015.
//  Copyright © 2015 Eoin Molloy. All rights reserved.
//

import UIKit
import Social
import AudioToolbox

struct Question {
    var question : String!
    var answers : [String]!
    var answer : Int!
}

class ViewController: UIViewController {
    
    @IBOutlet weak var Label: UILabel!
    @IBOutlet var buttons: [UIButton]!
    
    var CorrectSound: SystemSoundID!
    var WrongSound: SystemSoundID!
    
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
    
    func createSounds(){
        var soundID: SystemSoundID = 0
        
        var soundURL = CFBundleCopyResourceURL(CFBundleGetMainBundle(), "correct", "wav", nil)
        AudioServicesCreateSystemSoundID(soundURL, &soundID)
        CorrectSound = soundID
        soundID++
        
        soundURL = CFBundleCopyResourceURL(CFBundleGetMainBundle(), "wrong", "wav", nil)
        AudioServicesCreateSystemSoundID(soundURL, &soundID)
        WrongSound = soundID
        soundID++
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
        Question(question: "Current Fifa World cup champions ?", answers: ["England", "Argintina", "Spain", "Germany"], answer: 3),
        Question(question: "All-Ireland 2015 hurling Champions ?", answers: ["Wexford", "Cork", "Kilkenny", "Galway"], answer: 2),
        Question(question: "Muhammad Ali's boxing record ?", answers: ["53-4", "46-3", "50-0", "55-5"], answer: 3),
        Question(question: "Winner of First superbowl in 1967 ?", answers: ["Kansas City Chiefs", "Green Bay Packers", "San Diego Chargers", "Pittsburgh Steelers"], answer: 1),
        Question(question: "Republic of Ireland All-Time top Goalscorer?", answers: ["Robbie Keane", "Clinton Morrison", "Shay Given", "Glen Whelan"], answer: 0),
        Question(question: "Most Passing yards in NFL history ?", answers: ["Tom Brady", "Peyton Manning", "Dan Marino", "Brett Farve"], answer: 1),
        Question(question: "Team with most Soccar European club tiles(Champions league)?", answers: ["Barcelona", "Bayern Munich", "Real Madrid", "Liverpool"], answer: 2),
        Question(question: "100 meter Sprint World Record holder ?", answers: ["Asafa Powell", "Usain Bolt", "Carl Lewis", "Calvin Smith"], answer: 1),
        Question(question: "In what year was the Rugby Football Union formed in London?", answers: ["1871", "1901", "1888", "1923"], answer: 0),
        Question(question: "In what year were women first allowed to participate in the Olympic games?", answers: ["1880", "1900", "1904", "1950"], answer: 1),
        Question(question: "What is the Highest capacity football stadium in England?", answers: ["Old Trafford", "Wembley", "The Emerites", "Anfield"], answer: 1),
        Question(question: "Which is the only country to have played in each and every World Cup?", answers: ["England", "Germany", "Brazil", "Argintina"], answer: 2),
        Question(question: "Which was the first African country to qualify for a World Cup?", answers: ["Eygpt", "Mali", "South Africa", "Nigeria"], answer: 0),
        Question(question: "What is the maximum time limit allowed to look for a lost ball in golf?", answers: ["15 minutes", "10 minutes", "20 minutes", "5 minutes"], answer: 3),
        Question(question: "Which sport did George Washington play with his troops?", answers: ["Baseball", "Soccar", "Rugby", "Cricket"], answer: 3),
        Question(question: "What is the highest possible break in snooker?", answers: ["121", "146", "147", "135"], answer: 2),
        Question(question: "Which boxer was an underdog with odds of 42:1 when he stunned Mike Tyson?", answers: ["Donnie Long", "Tony Tucker", "Mickey Spinks", "Buster Douglas"], answer: 3),
        Question(question: "How many red balls are used in a game of snooker?", answers: ["15", "11", "12", "14"], answer: 0),
        Question(question: "In motor racing, which flag is waved to show the winner?", answers: ["Black and White", "Black and Red", "White and Green", "Green and Red"], answer: 0),
        Question(question: "Who scored the winning penalty in the 2006 world cup final?", answers: ["Zidine Zidane", "Fabio Grosso", "Gattuso", "Fabio Cannavaro"], answer: 1),
        Question(question: "How many players are there in an ice hockey team?", answers: ["4", "6", "7", "8"], answer: 1),
        Question(question: "What is the flat rubber disc known as in ice hockey?", answers: ["Disc", "Ball", "Tape", "Puc"], answer: 3),
        Question(question: "In which sport is the Davis cup awarded?", answers: ["Rugby", "Tennis", "Archery", "Badmitton"], answer: 1),
        Question(question: "In which sport is the Stanley cup awarded?", answers: ["American football", "Ice Hockey", "Baseball", "Cricket"], answer: 1),
        Question(question: "Where was the FIFA World Cup held in 1986?", answers: ["France", "Brazil", "Mexico", "Germany"], answer: 2),
        Question(question: "In which Olympic sport is the wearing of a beard prohibited?", answers: ["Boxing", "Swimming", "Running", "Gymnastics"], answer: 0),
        Question(question: "How many periods is an ice hockey game divided into?", answers: ["1", "2", "3", "4"], answer: 2),
        Question(question: "What is the most valuable piece in a game of chess?", answers: ["Pawn", "King", "Queen", "Knight"], answer: 1),
        Question(question: "Which country did Baseball originate from?", answers: ["Ireland", "America", "England", "Canada"], answer: 1),
        Question(question: "Venus Williams is a famous name in which sport?", answers: ["Hockey", "Soccer", "Tennis", "Hurling"], answer: 2),
        Question(question: "Which British city is home to Everton Football Club?", answers: ["Liverpool", "Manchester", "London", "Birmingham"], answer: 0),
        Question(question: "Which number is located between 15 and 17 on a standard dartboard?", answers: ["2", "1", "13", "20"], answer: 0),
        Question(question: "Which country won the FIFA World Cup in the years of 1994 and 2002?", answers: ["France", "Spain", "Germany", "Brazil"], answer: 3),
        Question(question: "In golf, what is a hole completed in one under par called?", answers: ["Eagle", "Birdie", "Albetroos", "Bogie"], answer: 1),
        Question(question: "In darts, how many points do you get if you hit a bullseye?", answers: ["25", "50", "60", "40"], answer: 1),
        Question(question: "Craven Cottage has been the football stadium since 1896 for which London based team?", answers: ["Ipswich", "Brighton", "Portsmouth", "Fulham"], answer: 3),
        Question(question: "In football, in the Premiership, out of 20 teams how many are relegated each season?", answers: ["4", "2", "1", "3"], answer: 3),
        Question(question: "In snooker, which colour ball is potted last to complete the frame?", answers: ["Brown", "Red", "Black", "White"], answer: 2),
        Question(question: "Who scored the winning goal in the 2014 World Cup?", answers: ["Mario Goetze", "Lionel Messi", "Thomas Mueller", "Mats Hummels"], answer: 0),
        Question(question: "How many points is a saftey worth in American football?", answers: ["2", "3", "6", "7"], answer: 0),]
        
        
        var HighscoreDefault = NSUserDefaults.standardUserDefaults()
        if HighscoreDefault.valueForKey("Highscore") != nil {
            highScore = HighscoreDefault.valueForKey("Highscore") as! NSInteger
            Highscore.text = NSString(format: "Highscore: %i", highScore) as String
        }
        RandomQuestion()
        createSounds()
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
            Questions.removeAtIndex(questionNumber)
        }
        
        else {
                NSLog("done")
        }
    }
    
    
    @IBAction func button1(sender: AnyObject) {
        if answerNumber == 0 {
            scoreNum++
            AudioServicesPlaySystemSound(CorrectSound)
            RandomQuestion()
        }
        
        else {
            scoreNum = 0
            AudioServicesPlaySystemSound(WrongSound)
            RandomQuestion()
        }
        
    }

    @IBAction func button2(sender: AnyObject) {
        if answerNumber == 1 {
            scoreNum++
            AudioServicesPlaySystemSound(CorrectSound)
            RandomQuestion()
        }
            
        else {
            scoreNum = 0
            AudioServicesPlaySystemSound(WrongSound)
            RandomQuestion()
        }

        
    }
    
    @IBAction func button3(sender: AnyObject) {
        if answerNumber == 2 {
            scoreNum++
            AudioServicesPlaySystemSound(CorrectSound)
            RandomQuestion()
        }
            
        else {
            scoreNum = 0
                AudioServicesPlaySystemSound(WrongSound)
            RandomQuestion()
        }

    }
    
    @IBAction func button4(sender: AnyObject) {
        if answerNumber == 3 {
            scoreNum++
            AudioServicesPlaySystemSound(CorrectSound)
            RandomQuestion()
        }
            
        else {
            scoreNum = 0
            AudioServicesPlaySystemSound(WrongSound)
            RandomQuestion()
        }

    }
    
    
    
}

