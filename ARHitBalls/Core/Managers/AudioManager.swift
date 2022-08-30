//
//  AudioManager.swift
//  ARHitBalls
//
//  Created by Swift Learning on 30.08.2022.
//

import AVFoundation

protocol AudioManagerable {
    func getSound(forResource: String, withExtension: String)
}

final class AudioManager {
    
    private var musicPlayer: AVAudioPlayer?
    
    init(musicPlayer: AVAudioPlayer?) {
        self.musicPlayer = musicPlayer
    }
}

extension AudioManager: AudioManagerable {
    
    func getSound(forResource: String, withExtension: String) {
        guard let url = Bundle.main.url(forResource: forResource, withExtension: withExtension) else {
            return
        }
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            musicPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            guard let player = musicPlayer else {
                return
            }
            player.play()
        } catch {
            fatalError()
        }
    }
}






