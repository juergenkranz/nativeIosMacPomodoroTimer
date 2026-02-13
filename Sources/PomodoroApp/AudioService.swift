import Foundation
import AVFoundation
import AudioToolbox

class AudioService: NSObject, AVSpeechSynthesizerDelegate {
    private let synthesizer = AVSpeechSynthesizer()
    
    // System Sound IDs (standard iOS system sounds)
    // 1005: Alarm
    // 1022: Begin Record (nice chime)
    // 1023: End Record (nice chime)
    // 1057: PIN Pressed (short beep)
    
    func playStartTone() {
        AudioServicesPlaySystemSound(1113) // Begin recording tone
    }
    
    func playEndTone() {
        AudioServicesPlaySystemSound(1114) // End recording tone
    }
    
    func playBeep() {
        AudioServicesPlaySystemSound(1057) // Short beep
    }
    
    func announce(text: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.rate = 0.5
        utterance.pitchMultiplier = 1.0
        utterance.volume = 1.0
        
        // Ensure audio session is active
        #if os(iOS)
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: .duckOthers)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Failed to set audio session: \(error)")
        }
        #endif
        
        synthesizer.speak(utterance)
    }
}
