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

protocol BoutTime {
    var playerScore: Int { get set }
    var roundsPerGame: Int { get }
    var roundsCompleted: Int { get set }
    var audioPlayer: SoundEffectsPlayer { get set }
    var eventsGenerator: BoutTimeRandomEventsGenerator { get set }
    
    func evaluateOrderOf(events: [BoutTimeEvent]) -> Bool
}

struct BoutTimeGame: BoutTime {
    var playerScore = 0
    let roundsPerGame: Int
    var roundsCompleted = 0
    var audioPlayer = SoundEffectsPlayer()
    var eventsGenerator: BoutTimeRandomEventsGenerator
    
    init(havingRounds rounds: Int, withGameEventsGenerator eventsGenerator: BoutTimeRandomEventsGenerator) {
        self.eventsGenerator = eventsGenerator
        self.roundsPerGame = rounds
    }
    
    /// Instance method to evaluate the correctness of game events ordered by the user
    func evaluateOrderOf(events: [BoutTimeEvent]) -> Bool {
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
