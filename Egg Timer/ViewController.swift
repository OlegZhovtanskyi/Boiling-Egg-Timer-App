//
//  ViewController.swift
//  Egg Timer
//
//  Created by Oleg Zhovtanskyi on 17/04/2023.
//

import UIKit

class ViewController: UIViewController {
    let eggTime = ["softButton" : 240, "mediumButton": 360, "hardButton": 720]
    var currentTime = 0
    var choosenButton = 0
    var buttonText = ""
    
    @IBOutlet weak var mainLabel: UILabel!
    
    @IBOutlet weak var eggTimeProgress: UIProgressView!
    
    
    @IBOutlet weak var softButton: UIButton!
    @IBOutlet weak var mediumButton: UIButton!
    @IBOutlet weak var hardButton: UIButton!
    
    
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




}

