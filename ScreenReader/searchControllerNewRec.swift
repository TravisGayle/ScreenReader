//
//  searchControllerNewRec.swift
//  ScreenReader
//
//  Created by Matthew Lanus (2018) on 2/26/18.
//  Copyright © 2018 TravisGayle. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class searchControllerNewRec: UIViewController, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate {
    
    //MARK: Properties
    
    //@IBOutlet weak var backButton: UIButton!
    //@IBOutlet weak var repeatButton: UIButton!
    //@IBOutlet weak var nextButton: UIButton!
    
    var doot = ""
    var recipetitle = "A New Recipe"
    var ingredients = [""]
    var instructions = [""]
    var counter = -1
    let ss:AVSpeechSynthesizer = AVSpeechSynthesizer()
    //var lasagna = "http://allrecipes.com/recipe/14054/lasagna/?internalSource=hub%20recipe&referringContentType=search%20results&clickId=cardslot%202"
    //var pancake = "http://allrecipes.com/recipe/8056/pancakes/?internalSource=hub%20recipe&referringContentType=search%20results&clickId=cardslot%202"
    //var omelet = "http://allrecipes.com/recipe/33109/aussie-omelet/?internalSource=rotd&referringId=1314&referringContentType=recipe%20hub&clickId=cardslot%201"
    //var chickenKabobs = "http://allrecipes.com/recipe/19934/chili-lime-chicken-kabobs/?internalSource=streams&referringId=201&referringContentType=recipe%20hub&clickId=st_trending_b"
    
    
    var recipeDict = ["Pancakes": "http://allrecipes.com/recipe/8056/pancakes/?internalSource=hub%20recipe&referringContentType=search%20results&clickId=cardslot%202", "Lasagna": "http://allrecipes.com/recipe/14054/lasagna/?internalSource=hub%20recipe&referringContentType=search%20results&clickId=cardslot%202","Omelet":"http://allrecipes.com/recipe/33109/aussie-omelet/?internalSource=rotd&referringId=1314&referringContentType=recipe%20hub&clickId=cardslot%201","Kabobs":"http://allrecipes.com/recipe/19934/chili-lime-chicken-kabobs/?internalSource=streams&referringId=201&referringContentType=recipe%20hub&clickId=st_trending_b","Brownies":"http://allrecipes.com/recipe/238654/brookies-brownie-cookies/?internalSource=staff%20pick&referringId=79&referringContentType=recipe%20hub","Baked Macaroni":"http://allrecipes.com/recipe/24321/moms-favorite-baked-mac-and-cheese/?internalSource=hub%20recipe&referringContentType=search%20results&clickId=cardslot%204"]
    
    func getRecipe(recipeNo: String) {
        let url = URL(string: recipeDict[recipeNo]!)
        
        
        func findall(regex: String, text: String) -> [String] {
            
            do {
                let regex = try NSRegularExpression(pattern: regex, options: [])
                let nsString = text as NSString
                let results = regex.matches(in: text,
                                            options: [], range: NSMakeRange(0, nsString.length))
                return results.map { nsString.substring(with: $0.rangeAt( 1))}
            } catch let error as NSError {
                print("invalid regex: \(error.localizedDescription)")
                return []
            }
        }
        
        let task = URLSession.shared.dataTask(with: url!) {(data, response, error) in
            let html = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            
            //print(findall(regex: "<span class=\"recipe-ingred[^>]*itemprop=\"ingredients\">([^<]*)<", text:html! as String))
            
            self.ingredients = findall(regex: "<span class=\"recipe-ingred[^>]*itemprop=\"ingredients\">([^<]*)<", text:html! as String)
            for element in self.ingredients {
                print(element)
            }
            //print(findall(regex: "<span class=\"recipe-directions[^>]*>([^<]*)<", text:html! as String))
            
            self.instructions = findall(regex: "<span class=\"recipe-directions[^>]*>([^<]*)<", text:html! as String)
            
            let characterArray = self.instructions.flatMap { String.CharacterView($0) }
            
            let string = String(characterArray).trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            self.instructions = string.components(separatedBy: ".")
            
        }
        
        task.resume()
        
    }
    
    @IBOutlet var theview: UIView!
    
    override func viewDidLoad() {
        print(doot)
        super.viewDidLoad()
        self.steps.text = recipetitle
        if (doot != "") {
            print("I AM LOADING")
            print(doot)
            let url = URL(string: "https://johnathonnow.github.io/RecipeReaderRecipes/"+doot)
            
            func findall(regex: String, text: String) -> [String] {
                
                do {
                    let regex = try NSRegularExpression(pattern: regex, options: [])
                    let nsString = text as NSString
                    let results = regex.matches(in: text,
                                                options: [], range: NSMakeRange(0, nsString.length))
                    return results.map { nsString.substring(with: $0.rangeAt( 1))}
                } catch let error as NSError {
                    print("invalid regex: \(error.localizedDescription)")
                    return []
                }
            }
            
            let task = URLSession.shared.dataTask(with: url!) {(data, response, error) in
                let xml = SWXMLHash.parse(data!)
                //for c in xml["serviceResponse"]["searchResults"]["recipeList"]["recipeSummary"].children {
                self.ingredients = xml["serviceResponse"]["recipe"]["ingredients"]["ingredient"].all.map { e in (e["displayText"].element?.text)! }
                self.instructions = xml["serviceResponse"]["recipe"]["methods"]["method"].all.map { e in (e["description"].element?.text)! }
                let characterArray = self.instructions.flatMap { String.CharacterView($0) }
                
                let string = String(characterArray).trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                self.instructions = string.components(separatedBy: ".")
                //self.steps.text = xml["serviceResponse"]["recipe"]["title"].element?.text
                self.theview.setNeedsLayout()
                self.theview.setNeedsDisplay()
                self.tv.reloadData()
                DispatchQueue.main.async {
                    self.tv.reloadData()
                }
                //}
            }
            
            task.resume()
            
            
        } else {
            getRecipe(recipeNo: "Pancakes")
        }
        self.steps.numberOfLines = 0
    }
    
    var searchActive = false
    //MARK: Actions
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true;
        print("GOOO")
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false;
        print("GOOO")
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
        print("GOOO")
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
        print("GOOO")
        performSegue(withIdentifier: "toResults", sender: nil)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
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
    }
    @IBAction func backButton(_ sender: Any) {
        //don't touch this we might break it
    }
    
    
    @IBAction func searchyboi(_ sender: Any) {
        
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
        
    }
    
    
    @IBAction func randomButton(_ sender: UIBarButtonItem) {
        
        let name = Array(recipeDict.keys)[Int(arc4random_uniform(UInt32(recipeDict.count)))] // The function arc4random_uniform(_:) takes one parameter, the upper bound. It’ll return a random number between 0 and this upper bound, minus 1.
        
        self.steps.text = name
        print(name)
        getRecipe(recipeNo: name )
    }
    
    @IBOutlet weak var tv: UITableView!
    @IBOutlet weak var steps: UILabel!
    
    // This function is called before the segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    }
    
    let sections = ["Ingredients"]
    
    
    //@IBOutlet weak var ingredient: UILabel!
    //Ingredients won't populate, unsure how to do it
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientsCell", for: indexPath)
        cell.textLabel?.text = ingredients[indexPath.row]
        return cell
    }
}

