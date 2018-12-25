//
//  Event.swift
//  'Bout Time
//
//  Created by Abhilash Muraleedharan on 25/12/18.
//  Copyright © 2018 AbhilashApps. All rights reserved.
//

protocol BoutTimeEvent {
    var description: String { get }
    var yearOfOccurrence: Int { get }
    var webURL: String { get }
}

struct Event: BoutTimeEvent {
    let description: String
    let yearOfOccurrence: Int
    let webURL: String
}
