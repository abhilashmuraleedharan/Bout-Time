//
//  RandomEventsGenerator.swift
//  'Bout Time
//
//  Created by Abhilash Muraleedharan on 15/08/18.
//  Copyright © 2018 AbhilashApps. All rights reserved.
//

import Foundation
import GameKit

protocol Event {
    var eventDescription: String { get set }
    var yearOfOccurrence: Int { get set }
    var webURL: String { get set }
    
    func getEventDescription() -> String
    func getYearOfOccurrence() -> Int
    func getWebURL() -> String
}

struct GameEvent: Event {
    var eventDescription: String
    var yearOfOccurrence: Int
    var webURL: String
    
    func getEventDescription() -> String {
        return eventDescription
    }
    
    func getYearOfOccurrence() -> Int {
        return yearOfOccurrence
    }
    
    func getWebURL() -> String {
        return webURL
    }
}

enum EventsGeneratorError: Error {
    case invalidResource
    case conversionFailure
    case invalidYearFormat
}

class PlistConverter {
    static func dictionary(fromFile name: String, ofType type: String) throws -> [String: [String]] {
        guard let path = Bundle.main.path(forResource: name, ofType: type) else {
            throw EventsGeneratorError.invalidResource
        }
        guard let dictionary = NSDictionary(contentsOfFile: path) as? [String: [String]] else {
            throw EventsGeneratorError.conversionFailure
        }
        return dictionary
    }
}

class EventsUnarchiver {
    static func gameEvents(fromDictionary dictionary: [String:[String]]) throws -> [Event] {
        var events = [Event]()
        for (key, value) in dictionary {
            if let year = Int(value[0]) {
                events.append(GameEvent(eventDescription: key, yearOfOccurrence: year, webURL: value[1]))
            } else {
                throw EventsGeneratorError.invalidYearFormat
            }
        }
        return events
    }
}

protocol EventsGenerator {
    var gameEvents: [Event] { get }
    init(gameEvents: [Event])
    func generateRandomGameEvents() -> [Event]
}

class RandomEventsGenerator: EventsGenerator {
    let gameEvents: [Event]
    let eventsPerRound = 4
    var indexOfSelectedEvent: Int = 0
    var eventsPresentedIndexes = [Int]()  // To keep track of indices of events that's already presented in a round
    
    required init(gameEvents: [Event]) {
        self.gameEvents = gameEvents
    }
    
    /// Instance method to get a set of 4 random events
    func generateRandomGameEvents() -> [Event] {
        var gameRoundEvents = [Event]()
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
}
