import Foundation
import SwiftUI

class TimerManager: ObservableObject {
    @Published var timeRemaining: TimeInterval = 25 * 60
    @Published var totalDuration: TimeInterval = 25 * 60
    @Published var isRunning = false
    @Published var announceTime = false
    
    private var timer: Timer?
    private let audioService = AudioService()
    
    var progress: Double {
        guard totalDuration > 0 else { return 0 }
        return 1.0 - (timeRemaining / totalDuration)
    }
    
    func setDuration(minutes: Int) {
        stop()
        totalDuration = TimeInterval(minutes * 60)
        timeRemaining = totalDuration
    }
    
    func toggleStartStop() {
        if isRunning {
            stop()
        } else {
            start()
        }
    }
    
    private var endTime: Date?
    
    func start() {
        guard !isRunning else { return }
        
        if timeRemaining <= 0 {
             timeRemaining = totalDuration
        }
        
        endTime = Date().addingTimeInterval(timeRemaining)
        isRunning = true
        audioService.playStartTone()
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
            self?.tick()
        }
    }
    
    func stop() {
        isRunning = false
        timer?.invalidate()
        timer = nil
    }
    
    func reset() {
        stop()
        timeRemaining = totalDuration
    }
    
    private func tick() {
        guard let endTime = endTime else { return }
        let now = Date()
        let remaining = endTime.timeIntervalSince(now)
        
        if remaining <= 0 {
            stop()
            timeRemaining = 0
            audioService.playEndTone()
            return
        }
        
        let previousRemaining = Int(timeRemaining)
        timeRemaining = remaining
        let currentRemaining = Int(remaining)
        
        // Only trigger events if the integer second changed
        if currentRemaining != previousRemaining {
             // Last 10 seconds beep
            if currentRemaining > 0 && currentRemaining <= 10 {
                audioService.playBeep()
            }
            
            // Minute announcements
            if announceTime && currentRemaining > 10 && currentRemaining % 60 == 0 {
                 let minutesLeft = currentRemaining / 60
                 let text = minutesLeft == 1 ? "1 minute left" : "\(minutesLeft) minutes left"
                 audioService.announce(text: text)
            }
        }
    }
}
