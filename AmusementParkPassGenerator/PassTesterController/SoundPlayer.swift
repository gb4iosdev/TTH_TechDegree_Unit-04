//
//  SoundPlayer.swift
//  AmusementParkPassGenerator
//
//  Created by Gavin Butler on 14-09-2019.
//  Copyright © 2019 Gavin Butler. All rights reserved.
//

import AVFoundation

class SoundPlayer {
    
    private var backgroundSoundEffect: AVAudioPlayer?
    
    private var accessGrantedSound: SystemSoundID = 0
    private var accessDeniedSound: SystemSoundID = 0
    
    func loadAccessSounds() {
        loadSounds(fromFile: "AccessGranted.wav", soundID: &accessGrantedSound)
        loadSounds(fromFile: "AccessDenied.wav", soundID: &accessDeniedSound)
    }
    
    private func loadSounds(fromFile fileName: String, soundID: inout SystemSoundID) {
        let path = Bundle.main.path(forResource: fileName, ofType: nil)
        let soundUrl = URL(fileURLWithPath: path!)
        AudioServicesCreateSystemSoundID(soundUrl as CFURL, &soundID)
    }
    
    func playAccessGrantedSound() {
        AudioServicesPlaySystemSound(accessGrantedSound)
    }
    
    func playAccessDeniedSound() {
        AudioServicesPlaySystemSound(accessDeniedSound)
    }
    
}
