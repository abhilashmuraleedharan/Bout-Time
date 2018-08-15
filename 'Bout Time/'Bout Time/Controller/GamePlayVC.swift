//
//  ViewController.swift
//  'Bout Time
//
//  Created by Abhilash Muraleedharan on 13/08/18.
//  Copyright © 2018 AbhilashApps. All rights reserved.
//

import UIKit

class GamePlayVC: UIViewController {

    //MARK: - IB Outlets
    @IBOutlet weak var event1Label: UILabel!
    @IBOutlet weak var event2Label: UILabel!
    @IBOutlet weak var event3Label: UILabel!
    @IBOutlet weak var event4Label: UILabel!
    
    @IBOutlet weak var fullDownButton: UIButton!
    @IBOutlet weak var fullUpButton: UIButton!
    @IBOutlet weak var halfUp1Button: UIButton!
    @IBOutlet weak var halfDown1Button: UIButton!
    @IBOutlet weak var halfUp2Button: UIButton!
    @IBOutlet weak var halfDown2Button: UIButton!
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var promptLabel: UILabel!
    @IBOutlet weak var successImage: UIImageView!
    @IBOutlet weak var failImage: UIImageView!
    
    //MARK: - Stored Properties
    let newGame: Game
    var gameTimer: Timer!
    var timerRunning: Bool = false
    var secondsLeft = 60
    
    required init?(coder aDecoder: NSCoder) {
        let player = GamePlayer()
        let gameAudio = SoundGenerator()
        
        do {
            let dictionary = try PlistConverter.dictionary(fromFile: "WorldEvents", ofType: "plist")
            let gameEventsList = try EventsUnarchiver.gameEvents(fromDictionary: dictionary)
            let eventsGenerator = RandomEventsGenerator(gameEvents: gameEventsList)
            newGame = Game(havingRounds: 6, player: player, audio: gameAudio, eventsGenerator: eventsGenerator)
        } catch let error {
            fatalError("\(error)")
        }
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let event1LabelTap = UITapGestureRecognizer(target: self, action: #selector(GamePlayVC.event1LabelTapped))
        let event2LabelTap = UITapGestureRecognizer(target: self, action: #selector(GamePlayVC.event2LabelTapped))
        let event3LabelTap = UITapGestureRecognizer(target: self, action: #selector(GamePlayVC.event3LabelTapped))
        let event4LabelTap = UITapGestureRecognizer(target: self, action: #selector(GamePlayVC.event4LabelTapped))
        
        disableEventLabels()
        
        event1Label.addGestureRecognizer(event1LabelTap)
        event2Label.addGestureRecognizer(event2LabelTap)
        event3Label.addGestureRecognizer(event3LabelTap)
        event4Label.addGestureRecognizer(event4LabelTap)

        
    }
    
    /// Timer Event Handler
    @objc func timeOutHandler() {
    }
    
    /// Disable labels user interactivity
    func disableEventLabels() {
        event1Label.isUserInteractionEnabled = false
        event2Label.isUserInteractionEnabled = false
        event3Label.isUserInteractionEnabled = false
        event4Label.isUserInteractionEnabled = false
    }
    
    /// Enable labels user interactivity
    func enableEventLabels() {
        event1Label.isUserInteractionEnabled = true
        event2Label.isUserInteractionEnabled = true
        event3Label.isUserInteractionEnabled = true
        event4Label.isUserInteractionEnabled = true
    }
    
    @objc func event1LabelTapped(sender:UITapGestureRecognizer) {
    }
    
    @objc func event2LabelTapped(sender:UITapGestureRecognizer) {
    }
    
    @objc func event3LabelTapped(sender:UITapGestureRecognizer) {
    }
    
    @objc func event4LabelTapped(sender:UITapGestureRecognizer) {
    }
    
    // To achieve a status bar with white content
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK:- IB Actions
    @IBAction func fullDownButtonTapped(_ sender: Any) {
    }
    
    @IBAction func halfUp1ButtonTapped(_ sender: Any) {
    }
    
    @IBAction func halfDown1ButtonTapped(_ sender: Any) {
    }
    
    @IBAction func halfUp2ButtonTapped(_ sender: Any) {
    }
    
    @IBAction func halfDown2ButtonTapped(_ sender: Any) {
    }
    
    @IBAction func fullUpButtonTapped(_ sender: Any) {
    }
    

}

