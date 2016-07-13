//
//  MovieViewController.swift
//  Movie
//
//  Created by John Whisker on 7/2/16.
//  Copyright © 2016 John Whisker. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import ARSLineProgress

class MovieViewController: UIViewController {
    var endpoint: String?
    @IBOutlet weak var tableView: UITableView!
    var Movies: [movie] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        ARSLineProgress.showOnView(view)
        loadData()
        tableView.dataSource = self
        tableView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
     // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPathForCell(cell)
        let movie = Movies[indexPath!.row]        
        let detailViewController = segue.destinationViewController as! DetailViewController
        detailViewController.currentmovie = movie
    }
    
}

// MARK: - DataSource for TableView

extension MovieViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard (self.Movies.count > 0) else { return 0 }
        return self.Movies.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MovieCell",forIndexPath: indexPath) as! MovieCell
        cell.titleLable.text = self.Movies[indexPath.row].title! as String
      //cell.overviewLable.text = self.Movies[indexPath.row].overview! as String
        if(self.Movies[indexPath.row].background != nil){
        cell.posterView.image = UIImage(data: NSData(contentsOfURL: self.Movies[indexPath.row].getURL(false))!)
      //cell.posterView = UIImage(data: NSData(contentsOfURL: self.Movies[indexPath.row].posterUrlLow)! as String)
        }
        return cell;
    }

}

// MARK: - Delegate TableView

extension MovieViewController: UITableViewDelegate {
    // nothing in here. Thanks for your wasted time. LOL =)))
}

//MARK: - Implement LoadDatafunction

extension MovieViewController {
    func loadData(){
        Alamofire.request(.GET, "https://api.themoviedb.org/3/movie/\(endpoint! as String)", parameters: ["api_key": "a07e22bc18f5cb106bfe4cc1f83ad8ed","page":"1"])
            .responseJSON { response in
                if let JSON = response.result.value {
                    if let results = JSON["results"] as! [NSDictionary]? {
                        for result in results {
                            let thisMovie : movie = movie()
                            thisMovie.initData(result)
                          //thisMovie.printOut()
                            self.Movies.append(thisMovie)
                            ARSLineProgress.hide()
                            self.tableView.reloadData()
                        }
                    }
                }
        }
        
    }

}