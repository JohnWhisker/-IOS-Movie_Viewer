//
//  FilterTableViewController.swift
//  Movie
//
//  Created by John Whisker on 7/13/16.
//  Copyright © 2016 John Whisker. All rights reserved.
//

import UIKit

protocol  filterDetailProtocol {
    func setValue(valueSent: FilterDetail)
}

class FilterTableViewController: UITableViewController {
    
    var delegate: filterDetailProtocol?
    var toSent:FilterDetail = FilterDetail()
    var showAdult: Bool = true
    @IBAction func switchStatusChange(sender: AnyObject) {
        if (showAdult){
            showAdult = false
            print ("No pornography")
            toSent.isAdult = showAdult
        } else{
            showAdult = true
            toSent.isAdult = showAdult
            print ("Lots of porn")
        }
    }
    
    @IBOutlet weak var releaseYearPiker: UIPickerView!
    @IBOutlet weak var primaryReleaseYear: UIPickerView!
    override func viewWillDisappear(animated: Bool) {
            delegate?.setValue(toSent)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        releaseYearPiker.dataSource = self
        primaryReleaseYear.dataSource = self
        releaseYearPiker.delegate = self
        primaryReleaseYear.delegate = self
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension FilterTableViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 117;
    }
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1;
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        
        return "\(row+1900)"
        
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == releaseYearPiker {
            toSent.releaseYear = "\(row+1900)"
            print("release year:\(row+1900)")
        } else if pickerView == primaryReleaseYear {
            toSent.primaryReleaseYear = "\(row+1900)"
            print("primary release year: \(row+1900)")
        }
    }
}


