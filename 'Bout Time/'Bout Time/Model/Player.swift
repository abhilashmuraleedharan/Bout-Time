//
//  Player.swift
//  'Bout Time
//
//  Created by Abhilash Muraleedharan on 15/08/18.
//  Copyright © 2018 AbhilashApps. All rights reserved.
//

protocol BoutPlayer {
    var gamePoints: Int { get set }
    func moveEvent(_ : GameControls)
    func shakePhone()
    func openEventWebView()
    func closeEventWebView()
    func playAgain()
}

class GamePlayer: BoutPlayer {
    var gamePoints = 0
    
    func moveEvent(_: GameControls) {
        
    }
    
    func shakePhone() {
        
    }
    
    func openEventWebView() {
        
    }
    
    func closeEventWebView() {

    }
    
    func playAgain() {
        
    }
}
