//
//  ResultViewController.swift
//  project4a
//
//  Created by Matt Pritchett on 12/15/19.
//  Copyright © 2019 Matt Pritchett. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    @IBOutlet weak var timeLabel: UILabel!
    var time: Double?
    override func viewDidLoad() {
        super.viewDidLoad()
        timeLabel.text = "\(time)"
    }
}
