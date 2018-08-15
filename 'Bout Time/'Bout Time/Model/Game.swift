//
//  Game.swift
//  'Bout Time
//
//  Created by Abhilash Muraleedharan on 15/08/18.
//  Copyright © 2018 AbhilashApps. All rights reserved.
//

enum GameControls {
    case fullUp
    case halfUp1
    case halfDown1
    case halfUp2
    case halfDown2
    case fullDown
}

protocol BoutGame {
    var playerScore: Int { get set }
    var roundsCompleted: Int { get set }
    var audio: SoundGeneratable { get set }
    var roundsPerGame: Int { get }
    var eventsGenerator: BoutEventsGenerator { get set }
    
    func evaluateOrderOf(events: [BoutGameEvent]) -> Bool
}

class Game: BoutGame {
    var playerScore = 0
    var roundsCompleted = 0
    var audio: SoundGeneratable
    let roundsPerGame: Int
    var eventsGenerator: BoutEventsGenerator
    
    init(havingRounds rounds: Int, audio: SoundGeneratable, eventsGenerator: BoutEventsGenerator) {
        self.audio = audio
        self.eventsGenerator = eventsGenerator
        self.roundsPerGame = rounds
    }
    
    /// Instance method to evaluate the correctness of game events ordered by the user
    func evaluateOrderOf(events: [BoutGameEvent]) -> Bool {
        var correctOrderOfYears = [Int]()    // Collection to hold the correct order of events by their year of occurrence
        var presentedOrderOfYears = [Int]()  // Collection to hold the presented order of events by their year of occurrence
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
