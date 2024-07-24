//
//  ViewController.swift
//  OpenTweet
//
//  Created by Olivier Larivain on 9/30/16.
//  Copyright © 2016 OpenTable, Inc. All rights reserved.
//

import UIKit
import SDWebImage

class TimelineViewController: UIViewController {

    let timelineViewModel = TimeLineViewModel()
    let cellReuseIdentifier = "CustomTweetTableCell"
    let cellNibName = "CustomTweetTableViewCell"
    var selectedRow: Int?
    var myTableTimeLine = UITableView()
    
	override func viewDidLoad() {
        super.viewDidLoad()
        // Change the tableview size to fit the screen, add to the view and register the cell for reuse
        myTableTimeLine.frame = CGRect(x: 10, y: 10, width: view.frame.width, height: view.frame.height)
        self.view.addSubview(myTableTimeLine)
        
        self.myTableTimeLine.register(UINib(nibName: cellNibName, bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)
        
        // setting the protocols to handle the tableview load/reload data
        timelineViewModel.setProtocol(timelineProtocol: self)
        myTableTimeLine.delegate = self
        myTableTimeLine.dataSource = self
               
        timelineViewModel.fetchTimelineFromJson()
	}

}

extension TimelineViewController: UITableViewDelegate, UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        timelineViewModel.getTimeLineTweetCounts()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = myTableTimeLine.dequeueReusableCell(withIdentifier: "CustomTweetTableCell") as? CustomTweetTableViewCell else {
            return UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "CustomTweetTableCell")
        }
        let tweet = timelineViewModel.getTweet(for: indexPath.row)
        cell.configure(tweet: tweet)
        return cell
    }
    
}

extension TimelineViewController: TimeLineProtocol {
    func reloadContent() {
        myTableTimeLine.reloadData()
    }
}
