//
//  ViewController.swift
//  EggTimer
//
//  Created by Muammer on 24.01.2023.
//

import UIKit

class ViewController: UIViewController {
    
    let eggTimes =  ["softTime" : 5, "mediumTime" : 8, "hardTime" : 12]
    
    var timer = Timer()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
        
        print(boiledTime)
        
        //timer.invalidate()
        }
}

