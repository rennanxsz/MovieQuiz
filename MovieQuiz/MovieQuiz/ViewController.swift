//
//  ViewController.swift
//  MovieQuiz
//
//  Created by Rennan Bruno on 24/02/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var viSoundBar: UIView!
    @IBOutlet weak var slMusic: UISlider!
    @IBOutlet var btOptions: [UIButton]!
    @IBOutlet weak var ivQuiz: UIImageView!
    
    var quizManager: QuizManager!

    override func viewDidLoad(){
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        quizManager = QuizManager()
        getNewQuiz()
    }
    
    func getNewQuiz() {
        let round = quizManager.generateRandomQuiz()
        for i in 0..<round.options.count{
            btOptions[i].setTitle(round.options[i].name, for: .normal)
        }
    }
    
    @IBAction func checkAnswer(_ sender: UIButton) {
    }
 
    @IBAction func changeMusicTime(_ sender: UISlider) {
    }
    
    @IBAction func showHideSoundBar(_ sender: UIButton) {
    }
    
    @IBAction func changeMusicStatus(_ sender: UIButton) {
    }
    
}

