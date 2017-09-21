//
//  searchController.swift
//  ScreenReader
//
//  Created by Travis Gayle on 5/4/17.
//  Copyright © 2017 TravisGayle. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class searchController: UIViewController {
    
    //MARK: Properties

    //@IBOutlet weak var backButton: UIButton!
    //@IBOutlet weak var repeatButton: UIButton!
    //@IBOutlet weak var nextButton: UIButton!
    var ingredients = [""]
    var instructions = [""]
    var counter = -1
    let ss:AVSpeechSynthesizer = AVSpeechSynthesizer()
    var lasagna = "http://allrecipes.com/recipe/14054/lasagna/?internalSource=hub%20recipe&referringContentType=search%20results&clickId=cardslot%202"
     
    var pancake = "http://allrecipes.com/recipe/8056/pancakes/?internalSource=hub%20recipe&referringContentType=search%20results&clickId=cardslot%202"
    
    func getRecipe() {
        let url = URL(string:lasagna)
        
        
        func findall(regex: String, text: String) -> [String] {
            
            do {
                let regex = try NSRegularExpression(pattern: regex, options: [])
                let nsString = text as NSString
                let results = regex.matches(in: text,
                                            options: [], range: NSMakeRange(0, nsString.length))
                return results.map { nsString.substring(with: $0.rangeAt(1))}
            } catch let error as NSError {
                print("invalid regex: \(error.localizedDescription)")
                return []
            }
        }
        
        let task = URLSession.shared.dataTask(with: url!) {(data, response, error) in
            let html = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            
            //print(findall(regex: "<span class=\"recipe-ingred[^>]*itemprop=\"ingredients\">([^<]*)<", text:html! as String))
            
            self.ingredients = findall(regex: "<span class=\"recipe-ingred[^>]*itemprop=\"ingredients\">([^<]*)<", text:html! as String)
            
            //print(findall(regex: "<span class=\"recipe-directions[^>]*>([^<]*)<", text:html! as String))
            
            self.instructions = findall(regex: "<span class=\"recipe-directions[^>]*>([^<]*)<", text:html! as String)
            
            let characterArray = self.instructions.flatMap { String.CharacterView($0) }
            
            let string = String(characterArray).trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            self.instructions = string.components(separatedBy: ".")
            
        }
        
        task.resume()

    }
    
    
    override func viewDidLoad() {
        print("HI FAM")
        super.viewDidLoad()
        getRecipe()
        self.steps.numberOfLines = 0
        self.steps.text = "Pancakes"
    }
    
    //MARK: Actions

    @IBAction func nextButton(_ sender: Any) {
        if (counter < instructions.count-1) {
            counter = counter + 1
        }
        
        print("NEXT!!")
        print(instructions[counter])
        self.steps.text = instructions[counter]
        let u:AVSpeechUtterance = AVSpeechUtterance(string: instructions[counter])
        ss.speak(u)
    }
    @IBAction func jesus(_ sender: Any) {
        if (counter <= 0) {
            counter = 0
        }
        else {
            counter = counter - 1
        }
        //counter = counter - 1
        print(instructions[counter])
        self.steps.text = instructions[counter]
        let u:AVSpeechUtterance = AVSpeechUtterance(string: instructions[counter])
        ss.speak(u)
        print("BACK BUTTON")
        //back button
    }
    @IBAction func backButton(_ sender: Any) {
        //don't touch this we might break it
    }
    
    @IBAction func repeatButton(_ sender: Any) {
        if (counter <= 0) {
            counter = 0
        } else if (counter >= instructions.count-1) {
            counter = instructions.count-1
        }
        print(instructions[counter])
        self.steps.text = instructions[counter]
        let u:AVSpeechUtterance = AVSpeechUtterance(string: instructions[counter])
        ss.speak(u)
        //print("JUJU REPEAT")
        
    }
    @IBOutlet weak var steps: UILabel!
    
    
}
