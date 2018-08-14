//
//  ViewController.swift
//  'Bout Time
//
//  Created by Abhilash Muraleedharan on 13/08/18.
//  Copyright © 2018 AbhilashApps. All rights reserved.
//

import UIKit

class GamePlayVC: UIViewController {

    @IBOutlet weak var event1Label: UILabel!
    @IBOutlet weak var event2Label: UILabel!
    @IBOutlet weak var event3Label: UILabel!
    @IBOutlet weak var event4Label: UILabel!
    
    @IBOutlet weak var fullDownButton: UIButton!
    @IBOutlet weak var fullUpButton: UIButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    // To achieve a status bar with white content
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // To return from Game Scores view back to Game Play view
    @IBAction func unwindFromGameScoresVC(segue: UIStoryboardSegue) {
        
    }


}

