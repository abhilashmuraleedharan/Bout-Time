//
//  RandomEventsGenerator.swift
//  'Bout Time
//
//  Created by Abhilash Muraleedharan on 15/08/18.
//  Copyright © 2018 AbhilashApps. All rights reserved.
//

import Foundation
import GameKit

enum BoutTimeEventsGeneratorError: Error {
    case invalidResource
    case conversionFailure
    case invalidYearFormat
}

struct PlistConverter {
    static func dictionary(fromFile name: String, ofType type: String) throws -> [String: [String]] {
        guard let path = Bundle.main.path(forResource: name, ofType: type) else {
            throw BoutTimeEventsGeneratorError.invalidResource
        }
        guard let dictionary = NSDictionary(contentsOfFile: path) as? [String: [String]] else {
            throw BoutTimeEventsGeneratorError.conversionFailure
        }
        return dictionary
    }
}

struct EventsUnarchiver {
    static func gameEvents(fromDictionary dictionary: [String:[String]]) throws -> [BoutTimeEvent] {
        var events = [BoutTimeEvent]()
        for (key, value) in dictionary {
            if let year = Int(value[0]) {
                events.append(Event(description: key, yearOfOccurrence: year, webURL: value[1]))
            } else {
                throw BoutTimeEventsGeneratorError.invalidYearFormat
            }
        }
        return events
    }
}

protocol BoutTimeRandomEventsGenerator {
    var gameEvents: [BoutTimeEvent] { get }
    func generateRandomEvents() -> [BoutTimeEvent]
}

struct RandomEventsGenerator: BoutTimeRandomEventsGenerator {
    let gameEvents: [BoutTimeEvent]  // Contains the whole set of events for the game
    let eventsPerRound = 4
    
    init(gameEvents: [BoutTimeEvent]) {
        self.gameEvents = gameEvents
    }
    
    /// Instance method to get a set of 4 random events
    func generateRandomEvents() -> [BoutTimeEvent] {
        var gameRoundEvents = [BoutTimeEvent]()
        var indexOfSelectedEvent = 0
        var presentedEventsIndices = [Int]()
        
        for _ in 1...eventsPerRound {
            indexOfSelectedEvent = GKRandomSource.sharedRandom().nextInt(upperBound: gameEvents.count)
            // To prevent getting same event in a round
            while (presentedEventsIndices.contains(indexOfSelectedEvent)) {
                indexOfSelectedEvent = GKRandomSource.sharedRandom().nextInt(upperBound: gameEvents.count)
            }
            // Store the indices of events already generated
            presentedEventsIndices.append(indexOfSelectedEvent)
            gameRoundEvents.append(gameEvents[indexOfSelectedEvent])
        }
        
        return gameRoundEvents
    }
    
    /// Instance method to view all game events details
    func printAllGameEvents() {
        var i = 1
        for event in gameEvents {
            print("Event \(i)")
            print("------------------------------------")
            print(event.description)
            print(event.yearOfOccurrence)
            print(event.webURL)
            print("")
            i += 1
        }
    }
}
