//
//  FirstViewController.swift
//  BayAreaChess
//
//  Created by Carlos Reyes on 4/8/15.
//  Copyright (c) 2015 Carlos Reyes. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet var tableView: UITableView!
    
    var items: [String] = ["We", "Heart", "Swift"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "TournamentCell")
        scrollView.contentSize.height = 1000
        navigationController?.hidesBarsOnSwipe = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.hidden = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.navigationBar.hidden = false
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell : TournamentTableViewCell = self.tableView.dequeueReusableCellWithIdentifier("TournamentCell", forIndexPath: indexPath) as! TournamentTableViewCell
        cell.configure("Wimbledon", date: "06/01/1992", imageName: "settings6.png")
        return cell
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        println(indexPath.row)
    }
    
    @IBAction func logout (sender: UIButton) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.removeObjectForKey("carlos")
        self.performSegueWithIdentifier("logout", sender: self)
    }
}