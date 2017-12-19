//
//  QuestionViewController.swift
//  PersonalityQuiz
//
//  Created by martynov on 2017-12-01.
//  Copyright © 2017 martynov. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var singleStackView: UIStackView!
    @IBOutlet weak var singleButton1: UIButton!
    @IBOutlet weak var singleButton2: UIButton!
    @IBOutlet weak var singleButton3: UIButton!
    @IBOutlet weak var singleButton4: UIButton!
    
    @IBOutlet weak var multiStackView: UIStackView!
    
    @IBOutlet weak var multiLabel1: UILabel!
    @IBOutlet weak var multiLabel2: UILabel!
    @IBOutlet weak var multiLabel3: UILabel!
    @IBOutlet weak var multiLabel4: UILabel!
    
    @IBOutlet weak var multiSwitch1: UISwitch!
    @IBOutlet weak var multiSwitch2: UISwitch!
    @IBOutlet weak var multiSwitch3: UISwitch!
    @IBOutlet weak var multiSwitch4: UISwitch!
    
    
    
    @IBAction func multiAnswerButtonPressed(_ sender: UIButton) {
        
        let currentAnswer = questions[questionIndex].answers
        
        if multiSwitch1.isOn {
            answerChoosen.append(currentAnswer[0])
        }
        if multiSwitch2.isOn {
            answerChoosen.append(currentAnswer[1])
        }
        if multiSwitch3.isOn {
            answerChoosen.append(currentAnswer[2])
        }
        if multiSwitch4.isOn {
            answerChoosen.append(currentAnswer[3])
        }
        
        
        nextQuestion()
    }
    
    
    @IBOutlet weak var rangedSlider: UISlider!
    
    @IBAction func rangeAnswerButtonPressed() {
        let currentAnswer = questions[questionIndex].answers
        
        // Converting Slider number into a answer index to get the animal
        if currentAnswer.count > 0 {
            let answerIndex = Int((rangedSlider.value / (1.0 / Float(currentAnswer.count)) - 1) + (1.0 / Float(currentAnswer.count)))
            
            let currentAnswer = questions[answerIndex].answers
            answerChoosen.append(currentAnswer[0])
            
            //print("Slider value: \(rangedSlider.value), Slider Animal = \(questions[questionIndex].answers[answerIndex].type)")
        }
        
        
        nextQuestion()
        
    }
    
    @IBOutlet weak var rangedStackView: UIStackView!
    
    @IBOutlet weak var rangedLabel1: UILabel!
    @IBOutlet weak var rangedLabel2: UILabel!
    
    @IBOutlet weak var questionProgressView: UIProgressView!
    
    var answerChoosen: [Answer] = []
    
    var questionIndex = 0
    
    var questions: [Question] = [
        Question(text: "Which food do you like?",
                 type: .single,
                 answers: [Answer(text: "Steak", type: .dog),
                           Answer(text: "Fish", type: .cat),
                           Answer(text: "Carrot", type: .rabbit),
                           Answer(text: "Corn", type: .turtle)]),
        
        Question(text: "Which activities do you enjoy?",
                 type: .multiple,
                 answers: [Answer(text: "Eating", type: .dog),
                           Answer(text: "Sleeping", type: .cat),
                           Answer(text: "Cuddling", type: .rabbit),
                           Answer(text: "Swimming", type: .turtle)]),
        Question(text: "How much do you enjoy car rides?",
                 type: .range,
                 answers: [Answer(text: "I dislike them", type: .cat),
                           Answer(text: "I get a little nervous", type: .rabbit),
                           Answer(text: "I barely notice them", type: .turtle),
                           Answer(text: "I love them", type: .dog)]),
        
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "ResultsSegue" {
            
            // passing answers to ResultViewController
            let resultViewController = segue.destination as! ResultsViewController
            
            resultViewController.responses = answerChoosen
            
            // hiding the Back button so we don have to deal with increasing questionIndex
            // if we go back
            resultViewController.navigationItem.setHidesBackButton(true, animated: false)
            
            _ = resultViewController
            
        }
        
    }
    
    func updateUI() {
        
        singleStackView.isHidden = true
        
        multiStackView.isHidden = true
        rangedStackView.isHidden = true
        
        navigationItem.title = "Question # \(questionIndex + 1)"
        navigationItem.setHidesBackButton(true, animated: false)
        
        let currentQuestion = questions[questionIndex]
        let currentAnswers = currentQuestion.answers
        
        questionLabel.text = currentQuestion.text
        let totalProgress = Float(questionIndex)/Float(questions.count)
        questionProgressView.setProgress(totalProgress, animated: true)
        
        switch currentQuestion.type {
        case .single: updateSingleStack(using: currentAnswers)
        case .multiple: updateMultiStack(using: currentAnswers)
        case .range: updateRangedStack(using: currentAnswers)
            
        }
        
        
    }
    
    func updateSingleStack(using answers: [Answer]) {
        singleStackView.isHidden = false
        singleButton1.setTitle(answers[0].text, for: .normal)
        singleButton2.setTitle(answers[1].text, for: .normal)
        singleButton3.setTitle(answers[2].text, for: .normal)
        singleButton4.setTitle(answers[3].text, for: .normal)
    }
    
    func updateMultiStack(using answers: [Answer]){
        multiStackView.isHidden = false
        multiSwitch1.isOn = false
        multiSwitch2.isOn = false
        multiSwitch3.isOn = false
        multiSwitch4.isOn = false
        
        multiLabel1.text = answers[0].text
        multiLabel2.text = answers[1].text
        multiLabel3.text = answers[2].text
        multiLabel4.text = answers[3].text
        
        
        
    }
    func updateRangedStack(using answers: [Answer]) {
        rangedStackView.isHidden = false
        rangedSlider.setValue(0.5, animated: true)
        rangedLabel1.text = answers.first?.text
        rangedLabel2.text = answers.last?.text
    }
    
    
    @IBAction func singleAnswerButtonPressed(_ sender: UIButton) {
        let currentAnswer = questions[questionIndex].answers
        switch sender {
        case singleButton1:  answerChoosen.append(currentAnswer[0])
        case singleButton2:  answerChoosen.append(currentAnswer[1])
        case singleButton3:  answerChoosen.append(currentAnswer[2])
        case singleButton4:  answerChoosen.append(currentAnswer[3])
        default: break
            
        }
        
        nextQuestion()
        
        
        
    }
    
    func nextQuestion() {
        
        questionIndex += 1
        
        if questionIndex < questions.count {
            updateUI()
        } else {
            performSegue(withIdentifier:
                "ResultsSegue"
                , sender: nil)
        }
        
        
    }
    
    
}
