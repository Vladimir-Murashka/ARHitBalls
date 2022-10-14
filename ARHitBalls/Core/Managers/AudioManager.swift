//
//  AudioManager.swift
//  ARHitBalls
//
//  Created by Swift Learning on 30.08.2022.
//

import AVFoundation

protocol AudioManagerable {
    func loadSound(
        forResource: String,
        withExtension: String
    )
    func play()
    func pause()
}

final class AudioManager {
    
    private var musicPlayer: AVAudioPlayer?
    
}

extension AudioManager: AudioManagerable {
    func play() {
        musicPlayer?.play()
    }
    
    func pause() {
        musicPlayer?.pause()
    }
    
    func loadSound(
        forResource: String,
        withExtension: String
    ) {
        guard let url = Bundle.main.url(
            forResource: forResource,
            withExtension: withExtension
        ) else {
            return
        }
        do {
            try AVAudioSession.sharedInstance().setCategory(
                .playback,
                mode: .default
            )
            try AVAudioSession.sharedInstance().setActive(true)
            
            musicPlayer = try AVAudioPlayer(
                contentsOf: url,
                fileTypeHint: AVFileType.mp3.rawValue
            )
        } catch {
            fatalError()
        }
    }
}






