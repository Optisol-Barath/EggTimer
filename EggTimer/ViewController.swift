//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var progessBar: UIProgressView!
    @IBOutlet weak var titleLabel: UILabel!
    
    let eggTimes = ["Soft": 3, "Medium": 5, "Hard": 7]
    
    var remainingTime: Int = 60
    var totalTime = 0
    var secondsRemain = 0
    
    var player: AVAudioPlayer?
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        Timer().invalidate()
        let hardness = sender.currentTitle!
        totalTime = eggTimes[hardness]!
        
        progessBar.progress = 0.0
        titleLabel.text = hardness
        secondsRemain = 0
        
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
    }
    
    @objc func updateTimer() {
        if secondsRemain <  totalTime {
            secondsRemain += 1
            progessBar.progress = Float(secondsRemain) / Float(totalTime)
        }
        else {
            Timer().invalidate()
            titleLabel.text = "DONE!!"
            playSound()
        }
    }
    
    func playSound() {
        guard let path = Bundle.main.path(forResource: "alarm_sound", ofType:"mp3") else {
            return }
        let url = URL(fileURLWithPath: path)

        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
