//
//  DetailViewController.swift
//  Movie
//
//  Created by John Whisker on 7/5/16.
//  Copyright © 2016 John Whisker. All rights reserved.
//

import UIKit
import ARSLineProgress

class DetailViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var overviewLable: UILabel!
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var backgroundView: UIImageView!
    @IBOutlet weak var viewLayout: UIView!
    internal var currentmovie: movie = movie()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentmovie.printOut()
        scrollView.contentSize = CGSize(width: scrollView.frame.size.width, height: viewLayout.frame.origin.y + viewLayout.frame.size.height + 55)
        viewLayout.layer.cornerRadius = 5
        backgroundView.af_setImageWithURL(self.currentmovie.getURL(true))
        titleLable.text = currentmovie.title
        overviewLable.text = currentmovie.overview
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
