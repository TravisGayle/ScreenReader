//
//  searchResultsController.swift
//  ScreenReader
//
//  Created by Julianna Yee on 11/1/17.
//  Copyright © 2017 TravisGayle. All rights reserved.
//

import UIKit

class searchResultsController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    struct myData {
        var RecipeLabel:String
        var DescriptionLabel:String
    }

    var dummyData: [myData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        dummyData = [myData(RecipeLabel: "Pumpkin Pie", DescriptionLabel: "Delicious and nutritious (not really)"),
                     myData(RecipeLabel:"Pumpkin Cookies", DescriptionLabel: "Don't forget to pair your cookies with a good ol' PSL"),
                     myData(RecipeLabel: "Pumpkin Bumpkin", DescriptionLabel: "Idk")]
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
