//
//  ProfileViewController.swift
//  BayAreaChess
//
//  Created by Carlos Reyes on 7/15/15.
//  Copyright (c) 2015 Carlos Reyes. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    
    var items: [String] = ["Wimbledon", "Roland-Garros", "US Open", "Australian Open"]
    var dates: [String] = ["June/July", "May/June", "August/September", "January"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.hidesBarsOnSwipe = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
        return self.items.count+1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if (indexPath.row == 0) {
            var cell : ProfileTableViewCell = self.tableView.dequeueReusableCellWithIdentifier("ProfileCell") as! ProfileTableViewCell
//            cell.userInteractionEnabled = false
            cell.myLogoutButton.addTarget(self, action: "logout", forControlEvents: .TouchUpInside)
            cell.configure("Carlos Reyes", subtitleName:"@theCzarlos", imageName: "sample.jpg")
            return cell
        }
        else {
            var cell : TournamentTableViewCell = self.tableView.dequeueReusableCellWithIdentifier("TournamentCell", forIndexPath: indexPath) as! TournamentTableViewCell
            cell.configure(items[indexPath.row-1], date: dates[indexPath.row-1], imageName: "settings6.png")
            return cell
        }

    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if (indexPath.row == 0) {
            return 375.0
        }
        else {
            return 80.0
        }
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        println(indexPath.row)
    }
    
    func logout() {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.removeObjectForKey("carlos")
        self.performSegueWithIdentifier("logout", sender: self)
    }
    
    
}