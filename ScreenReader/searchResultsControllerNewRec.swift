//
//  searchResultsControllerNewRec.swift
//  ScreenReader
//
//  Created by Matthew Lanus (2018) on 2/26/18.
//  Copyright © 2018 TravisGayle. All rights reserved.
//

import UIKit

class searchResultsControllerNewRec: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tv: UITableView!
    
    struct myData {
        var RecipeLabel:String
        var DescriptionLabel:String
        var id:String
    }
    
    var doot = "test";
    var out = ""
    
    var dummyData: [myData] = []
    
    override func viewDidLoad() {
        print("OK")
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print(doot)
        let url = URL(string: "https://johnathonnow.github.io/RecipeReaderRecipes/index.xml")
        
        
        let task = URLSession.shared.dataTask(with: url!) {(data, response, error) in
            let xml = SWXMLHash.parse(data!)
            //for c in xml["serviceResponse"]["searchResults"]["recipeList"]["recipeSummary"].children {
              self.dummyData = xml["serviceResponse"]["recipes"]["recipe"].all.map { e in myData(RecipeLabel: (e["title"].element?.text)! , DescriptionLabel: (e["description"].element?.text)!, id: (e["url"].element?.text)!) }
            
            //self.dummyData = xml["serviceResponse"]["recipe"]["methods"]["method"].all.map { e in (e["description"].element?.text)! }
            //print(xml["serviceResponse"]["searchResults"]["recipeList"]["recipeSummary"].all.map { e in e })
            self.tv.reloadData()
            DispatchQueue.main.async {
                self.tv.reloadData()
            }
            ///}
        }
        
        task.resume()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //    @IBAction func BackButtonSearchView(_ sender: UIButton) {
    //
    //    }
    
    
    
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
    
    // This function is called before the segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // get a reference to the second view controller
        if (segue.identifier=="toCustom") {
            let secondViewController = segue.destination as! searchControllerNewRec
            print(dummyData[(tv.indexPathForSelectedRow?.row)!].id)
            out = dummyData[(tv.indexPathForSelectedRow?.row)!].id
            // set a variable in the second view controller with the data to pass
            secondViewController.doot = out
            secondViewController.recipetitle = dummyData[(tv.indexPathForSelectedRow?.row)!].RecipeLabel
            //dummyData[(tv.indexPathForSelectedRow?.row)!].RecipeLabel
        }
    }
    
    /*
     // MARK: - Navigation
     //NSIndexPath *selectedIndexPath = [tableView indexPathForSelectedRow];
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

