//
//  SearchViewController.swift
//  Movie
//
//  Created by John Whisker on 7/11/16.
//  Copyright © 2016 John Whisker. All rights reserved.
//

import UIKit
import Alamofire
import ARSLineProgress
class SearchViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var valueFromFilter: FilterDetail?
    var keyWord: String?
    var searchBar = UISearchBar()
    var movies: [movie] = []
    

    
    @IBAction func onFilterPressed(sender: AnyObject) {
        self.performSegueWithIdentifier("filterSegue", sender: sender)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        searchBar.delegate = self
        navigationItem.titleView = searchBar
        searchBar.resignFirstResponder()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "filterSegue"){
            
        }
        if(segue.identifier == "detailView"){
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPathForCell(cell)
        let movie = movies[indexPath!.row]
        let detailViewController = segue.destinationViewController as! DetailViewController
        detailViewController.currentmovie = movie
        }
    }
 
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        keyWord = searchBar.text! as String
        movies.removeAll()
        ARSLineProgress.showOnView(view)
        loadData()
        self.searchBar.endEditing(true)
        // Here is where we call the movie api with the search term /search/movie
        // When we get the results back, we should update the table
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard (self.movies.count > 0) else { return 0 }
        return self.movies.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("searchCell",forIndexPath: indexPath) as! MovieCell
        cell.titleLable.text = self.movies[indexPath.row].title! as String
        //cell.overviewLable.text = self.Movies[indexPath.row].overview! as String
        if(self.movies[indexPath.row].background != ""){
            cell.posterView.image = UIImage(data: NSData(contentsOfURL: self.movies[indexPath.row].getURL(false))!)
            //cell.posterView = UIImage(data: NSData(contentsOfURL: self.Movies[indexPath.row].posterUrlLow)! as String)
        }
        return cell;
    }
}

extension SearchViewController {
    func loadData(){
        Alamofire.request(.GET, "https://api.themoviedb.org/3/search/movie", parameters: ["api_key": "a07e22bc18f5cb106bfe4cc1f83ad8ed","query":"\(keyWord! as String)"])
            .responseJSON { response in
                if let JSON = response.result.value {
                    if let results = JSON["results"] as! [NSDictionary]? {
                        print(results)
                        print(response.request)
                        for result in results {
                            print(result)
                            let thisMovie : movie = movie()
                            thisMovie.initData(result)
                            if(thisMovie.background == nil){
                                thisMovie.background = ""
                            }
                            thisMovie.printOut()
                            self.movies.append(thisMovie)
                            ARSLineProgress.showSuccess()
                            self.tableView.reloadData()
                        }
                        print(self.movies)
                    }
                }
        }
    }

}

// MARK: Implement the delegate protocol

extension  SearchViewController: filterDetailProtocol {

    func setValue(valueSent: FilterDetail) {
        self.valueFromFilter = valueSent
        print("\(self.valueFromFilter!.isAdult)")
    }
}

