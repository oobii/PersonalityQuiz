//
//  ResultsViewController.swift
//  PersonalityQuiz
//
//  Created by martynov on 2017-12-01.
//  Copyright © 2017 martynov. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {
    
    var responses: [Answer]!
    
    @IBOutlet weak var resultAnswerLabel: UILabel!
    
    @IBOutlet weak var resultDefinitionLabel: UILabel!
    
//    @IBAction func backFromResults(_ sender: UIBarButtonItem) {
//        print("Back from Results button pressed")
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        navigationItem.hidesBackButton = true
        calculatePersonalityResult()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func calculatePersonalityResult() {
        
        var frequencyOfAnswers: [AnimalType:Int] = [:]
        
        let responseTypes = responses.map {$0.type}
        
        for response in responseTypes {
            frequencyOfAnswers[response] = (frequencyOfAnswers[response] ?? 0) + 1
        }
        
//        let freqOfAnswersSorted =  frequencyOfAnswers.sorted(  by: { (pair1, pair2) -> Bool in {
//            return pair1.value > pair2.value }()
        
        let mostCommonAnswer =  frequencyOfAnswers.sorted { $0.1 > $1.1 }.first!.key
    
    
        
        print("\(mostCommonAnswer) - originally: \(frequencyOfAnswers)")
        resultAnswerLabel.text = "You are  a \(mostCommonAnswer.rawValue)!"
        resultDefinitionLabel.text = mostCommonAnswer.definition
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
