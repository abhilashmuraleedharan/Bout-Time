//
//  Game.swift
//  'Bout Time
//
//  Created by Abhilash Muraleedharan on 15/08/18.
//  Copyright © 2018 AbhilashApps. All rights reserved.
//

enum GameControls: String {
    case fullUp
    case halfUp1
    case halfDown1
    case halfUp2
    case halfDown2
    case fullDown
}

protocol BoutGame {
    var playerScore: Int { get set }
    var audio: SoundGeneratable { get set }
    var roundsPerGame: Int { get }
    var eventsGenerator: BoutEventsGenerator { get set }
    
    func evaluateOrderOf(events: [BoutGameEvent]) -> Bool
}

class Game: BoutGame {
    var playerScore: Int
    var audio: SoundGeneratable
    let roundsPerGame: Int
    var eventsGenerator: BoutEventsGenerator
    
    init(havingRounds rounds: Int, playerScore: Int, audio: SoundGeneratable, eventsGenerator: BoutEventsGenerator) {
        self.playerScore = playerScore
        self.audio = audio
        self.eventsGenerator = eventsGenerator
        self.roundsPerGame = rounds
    }
    
    func evaluateOrderOf(events: [BoutGameEvent]) -> Bool {
        var correctOrderOfYears = [Int]()
        var presentedOrderOfYears = [Int]()
        for event in events {
            presentedOrderOfYears.append(event.yearOfOccurrence)
        }
        // Sort game events in ascending order based on their year of occurrence and store the sorted array to a new collection
        let eventsInAscendingOrderOfOccurrence = events.sorted{ $0.yearOfOccurrence < $1.yearOfOccurrence }
        for event in eventsInAscendingOrderOfOccurrence {
            correctOrderOfYears.append(event.yearOfOccurrence)
        }
        return correctOrderOfYears == presentedOrderOfYears ? true : false
    }
}
