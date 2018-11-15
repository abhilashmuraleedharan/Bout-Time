//
//  ViewController.swift
//  'Bout Time
//
//  Created by Abhilash Muraleedharan on 13/08/18.
//  Copyright © 2018 AbhilashApps. All rights reserved.
//

import UIKit
import SafariServices

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
    var game: BoutTimeGame
    var gameTimer: Timer!
    var timerRunning = false
    var secondsLeft = 60
    var userSetEvents = [BoutTimeEvent]()
    
    required init?(coder aDecoder: NSCoder) {
        do {
            let dictionary = try PlistConverter.dictionary(fromFile: "WorldEvents", ofType: "plist")
            let gameEventsList = try EventsUnarchiver.gameEvents(fromDictionary: dictionary)
            let eventsGenerator = RandomEventsGenerator(gameEvents: gameEventsList)
            game = BoutTimeGame(havingRounds: 6, withGameEventsGenerator: eventsGenerator)
        } catch let error {
            fatalError("\(error.localizedDescription)")
        }
        super.init(coder: aDecoder)
    }
    
    //MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up Gesture Recognizers for non control UI elements
        let event1LabelTap = UITapGestureRecognizer(target: self, action: #selector(event1LabelTapped))
        let event2LabelTap = UITapGestureRecognizer(target: self, action: #selector(event2LabelTapped))
        let event3LabelTap = UITapGestureRecognizer(target: self, action: #selector(event3LabelTapped))
        let event4LabelTap = UITapGestureRecognizer(target: self, action: #selector(event4LabelTapped))
        let successImageTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(resultImageTapped))
        let failImageTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(resultImageTapped))
        
        // Assign Gesture Recognizers
        event1Label.addGestureRecognizer(event1LabelTap)
        event2Label.addGestureRecognizer(event2LabelTap)
        event3Label.addGestureRecognizer(event3LabelTap)
        event4Label.addGestureRecognizer(event4LabelTap)
        successImage.addGestureRecognizer(successImageTapRecognizer)
        failImage.addGestureRecognizer(failImageTapRecognizer)
        
        // Disable user interactivity of non control ui elements
        disableEventLabelsUserInteractivity()
        disableResultImagesUserInteractivity()
        
        setControlButtonImages()
        
        startGame()
    }
    
    // To achieve a status bar with white content
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // To detect shake gesture
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if event?.subtype == motion {
            endGameRound()
        }
    }
    
    // To pass data to another view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let gameScoresVC = segue.destination as? GameScoresVC {
            gameScoresVC.game = game
        }
    }
    
    //MARK:- IB Actions
    @IBAction func fullDownButtonTapped(_ sender: Any) {
        arrangeEvents(.fullDown)
    }
    
    @IBAction func halfUp1ButtonTapped(_ sender: Any) {
        arrangeEvents(.halfUp1)
    }
    
    @IBAction func halfDown1ButtonTapped(_ sender: Any) {
        arrangeEvents(.halfDown1)
    }
    
    @IBAction func halfUp2ButtonTapped(_ sender: Any) {
        arrangeEvents(.halfUp2)
    }
    
    @IBAction func halfDown2ButtonTapped(_ sender: Any) {
        arrangeEvents(.halfDown2)
    }
    
    @IBAction func fullUpButtonTapped(_ sender: Any) {
        arrangeEvents(.fullUp)
    }
    
    //MARK: - Methods
    func startGame() {
        game.playerScore = 0
        game.roundsCompleted = 0
        startNewRoundOfGame()
    }
    
    func checkAndProceedToNextRound() {
        if game.roundsCompleted == game.roundsPerGame {
            gameOver()
        } else {
            startNewRoundOfGame()
        }
    }
    
    func gameOver() {
        performSegue(withIdentifier: "gameScoresVCSegue", sender: self)
    }
    
    func startNewRoundOfGame() {
        successImage.isHidden = true
        failImage.isHidden = true
        disableEventLabelsUserInteractivity()
        disableResultImagesUserInteractivity()
        resetTimer()
        timerLabel.isHidden = false
        startTimer()
        enableControlButtonsUserInteractivity()
        userSetEvents = game.eventsGenerator.generateRandomEvents()
        presentEvents()
        promptLabel.text = "Shake to complete"
        game.roundsCompleted += 1
    }
    
    func presentEvents() {
        event1Label.text = userSetEvents[0].description
        event2Label.text = userSetEvents[1].description
        event3Label.text = userSetEvents[2].description
        event4Label.text = userSetEvents[3].description
    }
    
    /// Arranges event labels as per user input
    func arrangeEvents(_ controlButton: GameControls) {
        switch controlButton {
        case .fullDown:
            userSetEvents.swapAt(0, 1)
        case .halfUp1:
            userSetEvents.swapAt(1, 0)
        case .halfDown1:
            userSetEvents.swapAt(1, 2)
        case .halfUp2:
            userSetEvents.swapAt(2, 1)
        case .halfDown2:
            userSetEvents.swapAt(2, 3)
        case .fullUp:
            userSetEvents.swapAt(3, 2)
        }
        presentEvents()
    }
    
    /// Disable labels user interactivity
    func disableEventLabelsUserInteractivity() {
        event1Label.isUserInteractionEnabled = false
        event2Label.isUserInteractionEnabled = false
        event3Label.isUserInteractionEnabled = false
        event4Label.isUserInteractionEnabled = false
    }
    
    /// Enable labels user interactivity
    func enableEventLabelsUserInteractivity() {
        event1Label.isUserInteractionEnabled = true
        event2Label.isUserInteractionEnabled = true
        event3Label.isUserInteractionEnabled = true
        event4Label.isUserInteractionEnabled = true
    }
    
    /// Disable Result Images User Interactivity
    func disableResultImagesUserInteractivity() {
        successImage.isUserInteractionEnabled = false
        failImage.isUserInteractionEnabled = false
    }
    
    /// Enable Result Images User Interactivity
    func enableResultImagesUserInteractivity(){
        successImage.isUserInteractionEnabled = true
        failImage.isUserInteractionEnabled = true
    }
    
    /// Disable Control buttons User Interactivity
    func disableControlButtonsUserInteractivity() {
        fullUpButton.isUserInteractionEnabled = false
        fullDownButton.isUserInteractionEnabled = false
        halfUp1Button.isUserInteractionEnabled = false
        halfDown1Button.isUserInteractionEnabled = false
        halfUp2Button.isUserInteractionEnabled = false
        halfDown2Button.isUserInteractionEnabled = false
    }
    
    /// Enable Control Buttons User Interactivity
    func enableControlButtonsUserInteractivity() {
        fullUpButton.isUserInteractionEnabled = true
        fullDownButton.isUserInteractionEnabled = true
        halfUp1Button.isUserInteractionEnabled = true
        halfDown1Button.isUserInteractionEnabled = true
        halfUp2Button.isUserInteractionEnabled = true
        halfDown2Button.isUserInteractionEnabled = true
    }
    
    /// Timer Event Handler
    @objc func timeOutHandler() {
        secondsLeft -= 1
        timerLabel.text = "\(secondsLeft)"
        if (secondsLeft == 0) {
            endGameRound()
        }
    }
    
    /// End current game round
    func endGameRound() {
        gameTimer.invalidate()
        let result = game.evaluateOrderOf(events: userSetEvents)
        timerLabel.isHidden = true
        disableControlButtonsUserInteractivity()
        enableEventLabelsUserInteractivity()
        promptLabel.text = "Tap events to learn more"
        enableResultImagesUserInteractivity()
        if result {
            successImage.isHidden = false
            failImage.isHidden = true
            game.audioPlayer.playSoundEffectOf(.success)
            game.playerScore += 1
        } else {
            successImage.isHidden = true
            failImage.isHidden = false
            game.audioPlayer.playSoundEffectOf(.failure)
        }
    }
    
    
    /// Reset Timer
    func resetTimer() {
        secondsLeft = 60
        timerRunning = false
    }
    
    /// Start Timer
    func startTimer() {
        timerLabel.text = "\(secondsLeft)"
        if !timerRunning {
            gameTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timeOutHandler), userInfo: nil, repeats: true)
            timerRunning = true
        }
    }
    
    // Set Control Button Images
    func setControlButtonImages() {
        fullDownButton.setImage(UIImage(named: "down_full")?.withRenderingMode(.automatic), for: .normal)
        halfUp1Button.setImage(UIImage(named: "up_half")?.withRenderingMode(.automatic), for: .normal)
        halfDown1Button.setImage(UIImage(named: "down_half")?.withRenderingMode(.automatic), for: .normal)
        halfUp2Button.setImage(UIImage(named: "up_half")?.withRenderingMode(.automatic), for: .normal)
        halfDown2Button.setImage(UIImage(named: "down_half")?.withRenderingMode(.automatic), for: .normal)
        fullUpButton.setImage(UIImage(named: "up_full")?.withRenderingMode(.automatic), for: .normal)
        fullDownButton.setImage(UIImage(named: "down_full_selected")?.withRenderingMode(.automatic), for: .highlighted)
        halfUp1Button.setImage(UIImage(named: "up_half_selected")?.withRenderingMode(.automatic), for: .highlighted)
        halfDown1Button.setImage(UIImage(named: "down_half_selected")?.withRenderingMode(.automatic), for: .highlighted)
        halfUp2Button.setImage(UIImage(named: "up_half_selected")?.withRenderingMode(.automatic), for: .highlighted)
        halfDown2Button.setImage(UIImage(named: "down_half_selected")?.withRenderingMode(.automatic), for: .highlighted)
        fullUpButton.setImage(UIImage(named: "up_full_selected")?.withRenderingMode(.automatic), for: .highlighted)
    }
    
    @objc func event1LabelTapped(sender: UITapGestureRecognizer) {
        showWebsite(url: userSetEvents[0].webURL)
    }
    
    @objc func event2LabelTapped(sender: UITapGestureRecognizer) {
        showWebsite(url: userSetEvents[1].webURL)
    }
    
    @objc func event3LabelTapped(sender: UITapGestureRecognizer) {
        showWebsite(url: userSetEvents[2].webURL)
    }
    
    @objc func event4LabelTapped(sender: UITapGestureRecognizer) {
        showWebsite(url: userSetEvents[3].webURL)
    }
    
    @objc func resultImageTapped(sender: UITapGestureRecognizer)
    {
        checkAndProceedToNextRound()
    }
    
    /// Show WebPage with SFSafariViewController
    func showWebsite(url: String) {
        if let webURL = NSURL(string: url) {
            let safariVC = SFSafariViewController(url: webURL as URL)
            present(safariVC, animated: true, completion: nil)
        }
    }
}

