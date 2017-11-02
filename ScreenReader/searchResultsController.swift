//
//  searchResultsController.swift
//  ScreenReader
//
//  Created by Julianna Yee on 11/1/17.
//  Copyright © 2017 TravisGayle. All rights reserved.
//

import UIKit

class searchResultsController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tv: UITableView!
    
    struct myData {
        var RecipeLabel:String
        var DescriptionLabel:String
    }
    
    var doot = "";

    var dummyData: [myData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(doot)
        let url = URL(string: "http://services.bettycrocker.com/v2/search/recipes/true/"+doot+".xml")
        
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
            self.dummyData = xml["serviceResponse"]["searchResults"]["recipeList"]["recipeSummary"].all.map { e in myData(RecipeLabel: (e["title"].element?.text)! , DescriptionLabel: (e["title"].element?.text)!) }
            print(xml["serviceResponse"]["searchResults"]["recipeList"]["recipeSummary"].all.map { e in e["title"].element?.text })
            self.tv.reloadData()
            //}
        }
        
        task.resume()
        // Do any additional setup after loading the view.
    }

 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dummyData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Create a new cell with the reuse identifier of our prototype cell
        // as our custom table cell class
        let cell = tableView.dequeueReusableCell(withIdentifier: "myProtoCell") as! MyTableCellTableViewCell
        // Set the first row text label to the firstRowLabel data in our current array item
        cell.Recipe.text = dummyData[indexPath.row].RecipeLabel
        // Set the second row text label to the secondRowLabel data in our current array item
        cell.Description.text = dummyData[indexPath.row].DescriptionLabel
        // Return our new cell for display
        return cell
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
