//
//  RandomEventsGenerator.swift
//  'Bout Time
//
//  Created by Abhilash Muraleedharan on 15/08/18.
//  Copyright © 2018 AbhilashApps. All rights reserved.
//

import Foundation
import GameKit

protocol BoutGameEvent {
    var description: String { get set }
    var yearOfOccurrence: Int { get set }
    var webURL: String { get set }
}

struct Event: BoutGameEvent {
    var description: String
    var yearOfOccurrence: Int
    var webURL: String
}

enum BoutGameEventsGeneratorError: Error {
    case invalidResource
    case conversionFailure
    case invalidYearFormat
}

class PlistConverter {
    static func dictionary(fromFile name: String, ofType type: String) throws -> [String: [String]] {
        guard let path = Bundle.main.path(forResource: name, ofType: type) else {
            throw BoutGameEventsGeneratorError.invalidResource
        }
        guard let dictionary = NSDictionary(contentsOfFile: path) as? [String: [String]] else {
            throw BoutGameEventsGeneratorError.conversionFailure
        }
        return dictionary
    }
}

class EventsUnarchiver {
    static func gameEvents(fromDictionary dictionary: [String:[String]]) throws -> [BoutGameEvent] {
        var events = [Event]()
        for (key, value) in dictionary {
            if let year = Int(value[0]) {
                events.append(Event(description: key, yearOfOccurrence: year, webURL: value[1]))
            } else {
                throw BoutGameEventsGeneratorError.invalidYearFormat
            }
        }
        return events
    }
}

protocol BoutEventsGenerator {
    var gameEvents: [BoutGameEvent] { get }
    init(gameEvents: [BoutGameEvent])
    func generateRandomGameEvents() -> [BoutGameEvent]
    func printAllGameEvents()
}

class RandomEventsGenerator: BoutEventsGenerator {
    let gameEvents: [BoutGameEvent]  // Contains the whole set of events for the game
    let eventsPerRound = 4
    var indexOfSelectedEvent: Int = 0
    var eventsPresentedIndexes = [Int]()  // To keep track of indices of events that's already presented in a round
    
    required init(gameEvents: [BoutGameEvent]) {
        self.gameEvents = gameEvents
    }
    
    /// Instance method to get a set of 4 random events
    func generateRandomGameEvents() -> [BoutGameEvent] {
        var gameRoundEvents = [BoutGameEvent]()
        eventsPresentedIndexes = []
        for _ in 1...eventsPerRound {
            indexOfSelectedEvent = GKRandomSource.sharedRandom().nextInt(upperBound: gameEvents.count)
            // To prevent getting same event in a round
            while (eventsPresentedIndexes.contains(indexOfSelectedEvent)) {
                indexOfSelectedEvent = GKRandomSource.sharedRandom().nextInt(upperBound: gameEvents.count)
            }
            // Store the indices of events already generated
            eventsPresentedIndexes.append(indexOfSelectedEvent)
            gameRoundEvents.append(gameEvents[indexOfSelectedEvent])
        }
        return gameRoundEvents
    }
    
    /// Instance method to view all game events details
    func printAllGameEvents() {
        var i: Int = 1
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
