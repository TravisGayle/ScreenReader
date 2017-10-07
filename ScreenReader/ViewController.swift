//
//  ViewController.swift
//  ScreenReader
//
//  Created by Travis Gayle on 3/31/17.
//  Copyright © 2017 TravisGayle. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
       //UIButton.layer.cornerRadius = 10
//        self.view.backgroundColor = UIColor.red
        
//        UIView.animate(withDuration: 5, delay: 0.0, options:[UIViewAnimationOptions.repeat, UIViewAnimationOptions.autoreverse], animations: {
//            self.view.backgroundColor = UIColor.blue
//            self.view.backgroundColor = UIColor.green
//            self.view.backgroundColor = UIColor.orange
//            self.view.backgroundColor = UIColor.red
//        }, completion: nil)

    }

    
 
    
    @IBAction func exitButton(_ sender: Any) {
        print("Exit has been clicked!")
        exit(0);
    }
    
    @IBAction func searchButton(_ sender: UIButton) {
        //self.performSegue(withIdentifier: "searchController", sender: sender)
        print("Search has been clicked!")
        let ss:AVSpeechSynthesizer = AVSpeechSynthesizer()
        let u:AVSpeechUtterance = AVSpeechUtterance(string: "Hello, I am your personal recipe reader! Who's hungry for pancakes?")
        ss.speak(u)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
//    @IBAction func handleTap(sender:UITapGestureRecognizer) {
//        if sender.state == .ended {
//            print("bop bop bop, bop to the top")
//        }
//
//    }
    
}

