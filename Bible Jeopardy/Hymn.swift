//
//  Hymn.swift
//  Bible Jeopardy
//
//  Created by Allen Wilson on 7/24/22.
//

import AVFoundation

enum Hymn: String {
    case battleHymnOfTheRepublic
    case blestAndHappyIsTheMan
    case blowTheHornLetZionHear
    case byTheWatersOfBabylon
    case byThisShallAllMenKnow
    case godSpeaksToUs
    case holyMightyMajesty
    case howGoodAndHowPleasant
    case howLovelyAreThyDwellings
    case itWontBeLongNow
    case theLordIsMyShepherd
}

class SoundManager: NSObject, AVAudioPlayerDelegate {
    private var players: [AVAudioPlayer?] = [nil]
    
    static let shared = SoundManager()
    
    func play(_ filename: String, in channel: Int = 0) {
        if players.count <= channel {
            for _ in 0 ... channel - players.count {
                players.append(nil)
            }
        }
        
        guard let url = Bundle.main.url(forResource: filename, withExtension: "mp3") else {
            fatalError("No such file: \(filename)")
        }
        players[channel] = try? AVAudioPlayer(contentsOf: url)
        
        players[channel]?.play()
    }
    
    func stopSmoothly(_ channel: Int = 0, duration: Double) {
        if channel >= 0 && channel < players.count {
            players[channel]?.setVolume(0, fadeDuration: duration)
            DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                self.players[channel]?.stop()
            }
        }
    }
    
    func stop(_ channel: Int = 0) {
        if channel >= 0 && channel < players.count {
            players[channel]?.stop()
        }
    }
    
    func stopAll() {
        for i in 0 ..< players.count {
            players[i]?.stop()
        }
    }
}
