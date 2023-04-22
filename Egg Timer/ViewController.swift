//
//  ViewController.swift
//  Egg Timer
//
//  Created by Oleg Zhovtanskyi on 17/04/2023.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    //MARK: - Main variables and constant
    let eggTime = ["softButton" : 240, "mediumButton": 360, "hardButton": 720]
    var currentTime = 0
    var choosenButton = 0
    var buttonText = ""
    var player: AVAudioPlayer?
    
    //MARK: - IBoutlets for buttons label and progress bar
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var eggTimeProgress: UIProgressView!
    @IBOutlet weak var softButton: UIButton!
    @IBOutlet weak var mediumButton: UIButton!
    @IBOutlet weak var hardButton: UIButton!
    
    //MARK: - IBAction for action buttons
    @IBAction func buttonPressed(_ sender: UIButton) {
        if sender == softButton {
            choosenButton = self.eggTime["softButton"]!
            self.buttonText = sender.titleLabel!.text!
        } else if sender == mediumButton {
            choosenButton = self.eggTime["mediumButton"]!
            self.buttonText = sender.titleLabel!.text!
        } else if sender == hardButton {
            choosenButton = self.eggTime["hardButton"]!
            self.buttonText = sender.titleLabel!.text!
        } else {
            print("Error")
        }
        
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            self.currentTime += 1
            let progress = Float(self.currentTime)/Float(self.choosenButton)
            DispatchQueue.main.async {
                self.eggTimeProgress.progress = progress
                self.mainLabel.text = "You have chosen \(self.buttonText)-boiled eggs, they will be ready in \(self.choosenButton - self.currentTime) seconds"
            }
            
            if self.currentTime == self.choosenButton {
                DispatchQueue.main.async {
                    self.playSound()
                    self.mainLabel.text = "Eggs are already cooked"
                }
                timer.invalidate()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eggTimeProgress.progress = 0.0
    }
    
    func playSound() {
        guard let path = Bundle.main.path(forResource: "alarm", ofType: "mp3") else {return}
        let url = URL(fileURLWithPath: path)
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            self.player?.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }

}

