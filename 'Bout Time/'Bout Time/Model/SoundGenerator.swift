//
//  SoundGenerator.swift
//  'Bout Time
//
//  Created by Abhilash Muraleedharan on 15/08/18.
//  Copyright © 2018 AbhilashApps. All rights reserved.
//

import AudioToolbox

enum GameSound {
    case success
    case failure
}

protocol SoundGeneratable {
    func playSoundOf(_ : GameSound)
}

enum SoundError: Error {
    case invalidResource
}

class SoundGenerator: SoundGeneratable {
    var sound: SystemSoundID = 0
    var gameSound: SystemSoundID = 0
    
    /// Instance method to play sound
    func playSoundOf(_ state: GameSound) {
        do {
            switch state {
            case .success:
                sound = try load(sound: "CorrectDing", ofType: "wav")
                play(gameSound: sound)
            case .failure:
                sound = try load(sound: "IncorrectBuzz", ofType: "wav")
                play(gameSound: sound)
                
            }
        } catch SoundError.invalidResource {
            print("Unable to load sound. Necessary wav files are missing")
        } catch let error {
            print("\(error)")
        }
    }
    
    /// Helper method to load a game sound
    func load(sound: String, ofType type: String) throws -> SystemSoundID {
        guard let path = Bundle.main.path(forResource: sound, ofType: type) else {
            throw SoundError.invalidResource
        }
        let soundUrl = URL(fileURLWithPath: path)
        AudioServicesCreateSystemSoundID(soundUrl as CFURL, &gameSound)
        return gameSound
    }
    
    /// Helper method to play a game sound
    func play(gameSound: SystemSoundID) {
        AudioServicesPlaySystemSound(gameSound)
    }
}
