import SwiftUI

struct ContentView: View {
    @StateObject private var timerManager = TimerManager()
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 40) {
                // Header
                Text("Pomodoro")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                // Timer Display
                ZStack {
                    // Background Circle
                    Circle()
                        .stroke(lineWidth: 20)
                        .opacity(0.3)
                        .foregroundColor(Color.gray)
                    
                    // Progress Circle
                    Circle()
                        .trim(from: 0.0, to: CGFloat(timerManager.progress))
                        .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
                        .foregroundColor(Color.orange)
                        .rotationEffect(Angle(degrees: 270.0))
                        .animation(.linear(duration: 0.1), value: timerManager.progress)
                    
                    // Time Text
                    Text(timeString(from: timerManager.timeRemaining))
                        .font(.system(size: 80, weight: .bold, design: .monospaced))
                        .foregroundColor(.white)
                }
                .padding(20)
                
                // Duration Selection
                HStack(spacing: 30) {
                    Button(action: {
                        timerManager.setDuration(minutes: 5)
                    }) {
                        Text("5 min")
                            .font(.headline)
                            .padding()
                            .background(timerManager.totalDuration == 300 ? Color.orange : Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    
                    Button(action: {
                        timerManager.setDuration(minutes: 25)
                    }) {
                        Text("25 min")
                            .font(.headline)
                            .padding()
                            .background(timerManager.totalDuration == 1500 ? Color.orange : Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                
                // Controls
                HStack(spacing: 40) {
                    Button(action: {
                        timerManager.toggleStartStop()
                    }) {
                        Image(systemName: timerManager.isRunning ? "pause.circle.fill" : "play.circle.fill")
                            .resizable()
                            .frame(width: 80, height: 80)
                            .foregroundColor(.orange)
                    }
                    
                    Button(action: {
                        timerManager.reset()
                    }) {
                        Image(systemName: "arrow.counterclockwise.circle.fill")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .foregroundColor(.gray)
                    }
                }
                
                // Settings
                Toggle("Announce Time Left", isOn: $timerManager.announceTime)
                    .padding()
                    .foregroundColor(.white)
                    .tint(.orange)
            }
            .padding()
        }
    }
    
    func timeString(from time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
