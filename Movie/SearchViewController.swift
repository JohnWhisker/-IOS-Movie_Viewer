//
//  SearchViewController.swift
//  Movie
//
//  Created by John Whisker on 7/11/16.
//  Copyright © 2016 John Whisker. All rights reserved.
//

import UIKit
import Alamofire
class SearchViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!

    var filltered: [NSNumber]!
    let array: [NSNumber] = [1,2,3,4,5,6,7,8,9,10]
    
    var searchBar = UISearchBar()

    override func viewDidLoad() {
        super.viewDidLoad()
        filltered = array
        tableView.dataSource = self
        searchBar.delegate = self
        loadData()
        navigationItem.titleView = searchBar
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
     /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        print("Hello, we are searching for \(searchBar.text)")
        // Here is where we call the movie api with the search term /search/movie
        // When we get the results back, we should update the table
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell()
        cell.textLabel?.text = "\(array[indexPath.row])"
        return cell
    }
}

extension SearchViewController {
    func loadData(){
        Alamofire.request(.GET, "https://api.themoviedb.org/3/search/movie", parameters: ["api_key": "a07e22bc18f5cb106bfe4cc1f83ad8ed","query":"dory"])
            .responseJSON { response in
                if let JSON = response.result.value {
                    if let results = JSON["results"] as! [NSDictionary]? {
                        print(results)
                        print(response.request)
                        for result in results {
                            print(result)
                          
                            //let thisMovie : movie = movie()
                            //thisMovie.initData(result)
                            //thisMovie.printOut()
                           // self.Movies.append(thisMovie)
                            //self.tableView.reloadData()
                        }
                    }
                }
        }
        
    }

}

