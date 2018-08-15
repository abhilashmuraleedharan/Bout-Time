//
//  GameScoresVC.swift
//  'Bout Time
//
//  Created by Abhilash Muraleedharan on 14/08/18.
//  Copyright © 2018 AbhilashApps. All rights reserved.
//

import UIKit

class GameScoresVC: UIViewController {

    //MARK: - IB Outlets
    @IBOutlet weak var scoresLabel: UILabel!
    
    var boutGame: Game?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let game = boutGame {
            scoresLabel.text = "\(game.playerScore)/\(game.roundsPerGame)"
        }
    }
    
    // To achieve a status bar with white content
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK: - IB Functions
    @IBAction func playAgainButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "gamePlayVCSegue", sender: self)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
