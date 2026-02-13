import SwiftUI

struct ContentView: View {
    @StateObject private var timerManager = TimerManager()
    @State private var selectedTheme: Theme = .standard
    
    var body: some View {
        ZStack {
            selectedTheme.backgroundColor.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 40) {
                // Header & Theme Picker
                HStack {
                    Text("Pomodoro")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(selectedTheme.primaryTextColor)
                    
                    Spacer()
                    
                    Menu {
                        Picker("Theme", selection: $selectedTheme) {
                            ForEach(Theme.allThemes) { theme in
                                Text(theme.name).tag(theme)
                            }
                        }
                    } label: {
                        Image(systemName: "paintpalette.fill")
                            .foregroundColor(selectedTheme.accentColor)
                            .font(.title2)
                    }
                }
                .padding(.horizontal)
                .padding(.top, 40) // Adjust for status bar/safe area if needed
                
                // Timer Display
                Text(timeString(from: timerManager.timeRemaining))
                    .font(.system(size: 80, weight: .bold, design: .monospaced))
                    .foregroundColor(selectedTheme.primaryTextColor)
                    .padding(20)
                
                // Duration Selection
                HStack(spacing: 30) {
                    Button(action: {
                        timerManager.setDuration(minutes: 5)
                    }) {
                        Text("5 min")
                            .font(.headline)
                            .padding()
                            .background(timerManager.totalDuration == 300 ? selectedTheme.accentColor : selectedTheme.buttonBackgroundColor)
                            .foregroundColor(selectedTheme.primaryTextColor)
                            .cornerRadius(10)
                    }
                    
                    Button(action: {
                        timerManager.setDuration(minutes: 25)
                    }) {
                        Text("25 min")
                            .font(.headline)
                            .padding()
                            .background(timerManager.totalDuration == 1500 ? selectedTheme.accentColor : selectedTheme.buttonBackgroundColor)
                            .foregroundColor(selectedTheme.primaryTextColor)
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
                            .foregroundColor(selectedTheme.accentColor)
                    }
                    
                    Button(action: {
                        timerManager.reset()
                    }) {
                        Image(systemName: "arrow.counterclockwise.circle.fill")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .foregroundColor(selectedTheme.buttonBackgroundColor)
                    }
                }
                
                // Settings
                Toggle("Announce Time Left", isOn: $timerManager.announceTime)
                    .padding()
                    .foregroundColor(selectedTheme.secondaryTextColor)
                    .tint(selectedTheme.accentColor)
            }
            .padding()
            
            // Edge Progress Indicator
            ZStack {
                // Background Track
                ContainerRelativeShape()
                    //.inset(by: 2) // Optional: fine-tune if needed, but standard shape should match
                    .stroke(selectedTheme.trackColor, lineWidth: 15)
                
                // Progress
                // Segment 1: From Top (0.75) to Right (1.0)
                ContainerRelativeShape()
                    .trim(from: 0.75, to: min(1.0, 0.75 + CGFloat(timerManager.progress)))
                    .stroke(selectedTheme.accentColor, style: StrokeStyle(lineWidth: 15, lineCap: .round, lineJoin: .round))
                    .animation(.linear(duration: 0.1), value: timerManager.progress)
                
                // Segment 2: From Right (0.0) to Top (0.75) - Handles wrap
                ContainerRelativeShape()
                    .trim(from: 0.0, to: CGFloat(max(0.0, timerManager.progress - 0.25)))
                    .stroke(selectedTheme.accentColor, style: StrokeStyle(lineWidth: 15, lineCap: .round, lineJoin: .round))
                    .animation(.linear(duration: 0.1), value: timerManager.progress)
            }
            .padding(7)
            .edgesIgnoringSafeArea(.all)
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
