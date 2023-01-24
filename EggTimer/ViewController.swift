//
//  ViewController.swift
//  EggTimer
//
//  Created by Muammer on 24.01.2023.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        if let text = sender.titleLabel?.text {
            print(text)
        }
    }
    
    
}

