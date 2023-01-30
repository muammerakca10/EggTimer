//
//  ViewController.swift
//  EggTimer
//
//  Created by Muammer on 24.01.2023.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {
    
    let eggTimes =  ["softTime" : 300, "mediumTime" : 420, "hardTime" : 720]
    var hardness : String?
    
    var boiling = false
    var boiledTime = 0
    
    var trigger : UNTimeIntervalNotificationTrigger?

    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var hardImage: UIImageView!
    @IBOutlet weak var mediumImage: UIImageView!
    @IBOutlet weak var softImage: UIImageView!
    @IBOutlet weak var selectTypeLabel: UILabel!
    @IBOutlet weak var waitingLabel: UILabel!
    @IBOutlet weak var readyLabel: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    
    var timer = Timer()
    
    var counter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        readyLabel.isHidden = true
        stopButton.isHidden = true
    }

    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        let center = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        content.title = "Egg Boiling Reminder"
        content.body = "Your eggs is ready!"
        content.sound = .defaultRingtone
        
        
        
        timer.invalidate()
        
        stopButton.titleLabel!.text = "Stop"
                
        hardness = sender.titleLabel?.text?.lowercased()
        
        switch hardness {
        case "soft" :
            boiledTime = eggTimes["softTime"]!
        case "medium" :
            boiledTime = eggTimes["mediumTime"]!
        case "hard" :
            boiledTime = eggTimes["hardTime"]!
        default:
            print("Error")
        }
        
        trigger = UNTimeIntervalNotificationTrigger(timeInterval: Double(boiledTime), repeats: false)

        let request = UNNotificationRequest(identifier: "reminder", content: content, trigger: trigger)

        center.add(request) { (error) in
            if error != nil {
                print("Error : \(String(describing: error?.localizedDescription))")
            } else {
                print("Success notification")
            }
        }
        
        counter = boiledTime
        
        //print(boiledTime)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateUI), userInfo: nil, repeats: true)
        timer.fire()
    }
    
    @objc func updateUI(){
        selectTypeLabel.textColor = .black
        readyLabel.isHidden = true
        
        if counter > 0 {
            progressBar.progress = Float(boiledTime - counter) / Float(boiledTime)
            stopButton.backgroundColor = .red
            stopButton.layer.cornerRadius = 5
            selectTypeLabel.text = "\(hardness!.uppercased()) selected. Remaining time = \(counter)"
            stopButton.isHidden = false
            waitingLabel.isHidden = true
            readyLabel.isHidden = true
            
            boiling = true
            
            if let hardness = hardness {
                if hardness == "soft"{
                    mediumImage.alpha = 0.5
                    hardImage.alpha = 0.5
                } else if hardness == "medium" {
                    softImage.alpha = 0.5
                    hardImage.alpha = 0.5
                } else if hardness == "hard" {
                    softImage.alpha = 0.5
                    mediumImage.alpha = 0.5
                }
            }
            
            print(counter)
            counter -= 1
            
        } else {
            progressBar.progress = 1
            boiling = false
            readyLabel.isHidden = false
            print("Egg is ready to eat")
            timer.invalidate()
            waitingLabel.isHidden = true
            readyLabel.isHidden = false
            stopButton.titleLabel?.text = "Restart"
            stopButton.backgroundColor = .green
            stopButton.layer.cornerRadius = 5
            selectTypeLabel.text = "FINISHED"
            selectTypeLabel.textColor = .red
        }
    }
    
    
    @IBAction func stopButtonTapped(_ sender: Any) {

        print(boiling)
        readyLabel.isHidden = true
        softImage.alpha = 1
        mediumImage.alpha = 1
        hardImage.alpha = 1
        stopButton.isHidden = true
        selectTypeLabel.textColor = .black
        selectTypeLabel.text = "Please Select Egg Type For Start Timer"
        waitingLabel.isHidden = false

        if boiling {
            timer.invalidate()
            counter = 0
        } else {
        }
    }
}
