//
//  ViewController.swift
//  MovieQuiz
//
//  Created by Rennan Bruno on 24/02/22.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var viSoundBar: UIView!
    @IBOutlet weak var slMusic: UISlider!
    @IBOutlet var btOptions: [UIButton]!
    @IBOutlet weak var ivQuiz: UIImageView!
    @IBOutlet weak var viTimer: UIView!
    
    var quizManager: QuizManager!
    var quizPlayer: AVAudioPlayer!

    override func viewDidLoad(){
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        quizManager = QuizManager()
        getNewQuiz()
        startTimer()
    }
    
    func getNewQuiz() {
        let round = quizManager.generateRandomQuiz()
        for i in 0..<round.options.count{
            btOptions[i].setTitle(round.options[i].name, for: .normal)
        }
        playQuiz()
    }
    
    func startTimer() {
        viTimer.frame = view.frame
        UIView.animate(withDuration: 60.0, delay: 0.0, options: .curveLinear, animations: {
            self.viTimer.frame.size.width = 0
            self.viTimer.frame.origin.x = self.view.center.x
            
        }) { (success) in
            self.gameOver()
        }
        
    }
    
    func gameOver() {
        performSegue(withIdentifier: "gameOverSegue", sender: nil)
        quizPlayer.stop()
    }
    
    func playQuiz() {
        guard let round = quizManager.round else {return}
        ivQuiz.image = UIImage(named: "movieSound")
        if let url = Bundle.main.url(forResource: "quote\(round.quiz.number)", withExtension: "mp3") {
            do {
                quizPlayer = try AVAudioPlayer(contentsOf: url)
                quizPlayer.volume = 1
                quizPlayer.delegate = self
                quizPlayer.play()
            } catch {
                
            }
        }
    }
    
    @IBAction func checkAnswer(_ sender: UIButton) {
        quizManager.checkAnswer(sender.title(for: .normal)!)
        getNewQuiz()
    }
 
    @IBAction func changeMusicTime(_ sender: UISlider) {
    }
    
    @IBAction func showHideSoundBar(_ sender: UIButton) {
        viSoundBar.isHidden = !viSoundBar.isHidden
    }
    
    @IBAction func changeMusicStatus(_ sender: UIButton) {
    }
    
}

extension ViewController: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        ivQuiz.image = UIImage(named: "movieSoundPause")
    }
}

