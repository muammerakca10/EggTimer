//
//  ViewController.swift
//  EggTimer
//
//  Created by Muammer on 24.01.2023.
//

import UIKit

class ViewController: UIViewController {
    
    let eggTimes =  ["softTime" : 5, "mediumTime" : 7, "hardTime" : 12]
    
    var timer = Timer()
    
    var counter = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        

    }


    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        var boiledTime = 0
        
        guard let hardness = sender.titleLabel?.text?.lowercased() else {return}
        
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
        
        counter = boiledTime
        
        //print(boiledTime)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateUI), userInfo: nil, repeats: true)
        timer.fire()
        
        }
    @objc func updateUI(){
        
        if counter > 0 {
            print(counter)
            counter -= 1
        } else {
            print("Egg is ready to eat")
            timer.invalidate()
        }
    }
}

