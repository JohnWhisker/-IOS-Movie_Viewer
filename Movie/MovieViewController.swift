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
import Firebase
import FirebaseDatabase

class MovieViewController: UIViewController {
    var endpoint: String?
    @IBOutlet weak var tableView: UITableView!
    var Movies: [movie] = []
    var devId: NSUUID?
    let FirebaseDatabase = FIRDatabase.database().reference()
    var refreshControl: UIRefreshControl?
    override func viewDidLoad() {
        super.viewDidLoad()
        devId = NSUUID.init(UUIDString: "17102A7B-75AB-4E97-AC17-72B1E7A5559C")
        ARSLineProgress.showOnView(view)
        loadData()
        //FirebaseDatabase.child("Test").setValue(false)
        tableView.dataSource = self
        tableView.delegate = self
        refreshControl = UIRefreshControl()
        refreshControl!.addTarget(self, action: #selector(refreshControlAction(_:)), forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl!, atIndex: 0)
    }
    
    func refreshControlAction(refreshControl: UIRefreshControl) {
        self.Movies.removeAll()
        loadData()
        
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
        cell.titleLable.textColor = UIColor.whiteColor()
        if(self.Movies[indexPath.row].background != nil){
        cell.posterView.image = UIImage(data: NSData(contentsOfURL: self.Movies[indexPath.row].getURL(false))!)
        }
        if(self.Movies[indexPath.row].isFavorite){
        cell.backgroundColor = UIColor.yellowColor()
        }else {
        cell.backgroundColor = UIColor.blackColor()
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
                            ARSLineProgress.hide()
                            self.tableView.reloadData()
                            self.refreshControl!.endRefreshing()
                        }
                    }
                }
        }
    }
    
    func readData(input: movie){
        let processingMovie = input
        self.FirebaseDatabase.observeEventType(.ChildAdded, withBlock: {snapshot in
            if(snapshot.hasChild("\(input.id! as NSNumber)" as String)){
                print(snapshot.value!.valueForKey("\(input.id! as NSNumber)" as String) as! Bool)
                processingMovie.isFavorite = snapshot.value!.valueForKey("\(input.id! as NSNumber)" as String) as! Bool
            }
        })
        self.Movies.append(processingMovie)
    }
}


//MARK: -- Implement Swipe for table cell

extension MovieViewController {
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    }
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let shareAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Share" , handler: { (action:UITableViewRowAction!, indexPath:NSIndexPath!) -> Void in
            let shareMenu = UIAlertController(title: nil, message: "Share using", preferredStyle: .ActionSheet)
            let twitterAction = UIAlertAction(title: "Twitter", style: UIAlertActionStyle.Default, handler: nil)
            let facebookAction = UIAlertAction(title: "Facebook", style: UIAlertActionStyle.Default, handler: nil)
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
            shareMenu.addAction(twitterAction)
            shareMenu.addAction(cancelAction)
            shareMenu.addAction(facebookAction)
            self.presentViewController(shareMenu, animated: true, completion: nil)
        })
        let favoriteAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Favorite" , handler: { (action:UITableViewRowAction!, indexPath:NSIndexPath!) -> Void in
            self.Movies[indexPath.row].isFavorite = true
            let currentVendor = (self.devId?.UUIDString)! as String
            let currentMovieID: String = "\(self.Movies[indexPath.row].id! as NSNumber)"as String
            self.FirebaseDatabase.child("\(currentVendor as String)").child("\(currentMovieID)" ).setValue(true)
            tableView.reloadData()
        })
        favoriteAction.backgroundColor = UIColor.blueColor()
        return[shareAction,favoriteAction]
    }
}