//
//  Game.swift
//  'Bout Time
//
//  Created by Abhilash Muraleedharan on 15/08/18.
//  Copyright © 2018 AbhilashApps. All rights reserved.
//

import Foundation
import UIKit

enum GameControls: String {
    case fullUp
    case halfUp1
    case halfDown1
    case halfUp2
    case halfDown2
    case fullDown
}

enum TimerAction {
    case start
    case stop
}

enum GameState {
    case begin
    case end
}

protocol BoutGame {
    var player: BoutPlayer { get set }
    var timer: Timer { get set }
    var audio: SoundGeneratable { get set }
    var roundsPerGame: Int { get }
    var eventsGenerator: BoutEventsGenerator { get set }
    
    func game(_ : GameState)
    func presentEvents()
    func timer(_ : TimerAction)
    func moveEventLabel(_ : GameControls)
    func evaluateOrderOf(events: [BoutGameEvent]) -> Bool
    func displayResult()
    func timerExpired()
    func restartGame()
    func resumePlay()
}

class Game: BoutGame {
    var player: BoutPlayer
    var timer: Timer
    var audio: SoundGeneratable
    let roundsPerGame: Int
    var eventsGenerator: BoutEventsGenerator
    
    init(havingRounds rounds: Int, player : BoutPlayer, timer: Timer, audio: SoundGeneratable, eventsGenerator: BoutEventsGenerator) {
        self.player = player
        self.timer = timer
        self.audio = audio
        self.eventsGenerator = eventsGenerator
        self.roundsPerGame = rounds
    }
    
    func game(_: GameState) {
        
    }
    
    func presentEvents() {
        
    }
    
    func timer(_: TimerAction) {
        
    }
    
    func moveEventLabel(_: GameControls) {
        
    }
    
    func evaluateOrderOf(events: [BoutGameEvent]) -> Bool {
        let result = false
        return result
    }
    
    func displayResult() {
        
    }
    
    func timerExpired() {
        
    }
    
    func restartGame() {
        
    }
    
    func resumePlay() {
        
    }
}
