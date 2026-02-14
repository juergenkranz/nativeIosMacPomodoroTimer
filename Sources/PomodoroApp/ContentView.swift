import SwiftUI

struct ContentView: View {
    @StateObject private var timerManager = TimerManager()
    @AppStorage("selectedThemeID") private var selectedThemeID: String = Theme.standard.id
    
    var selectedTheme: Theme {
        Theme.allThemes.first(where: { $0.id == selectedThemeID }) ?? .standard
    }
    
    var body: some View {
        ZStack {
            selectedTheme.backgroundColor.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                Spacer()
                
                Spacer()
                
                // Timer Display
                Text(timeString(from: timerManager.timeRemaining))
                    .font(.system(size: 80, weight: .bold, design: .monospaced))
                    .foregroundColor(selectedTheme.primaryTextColor)
                    .padding(20)
                
                Spacer()
                
                Spacer()
                
                // Bottom Controls Section
                VStack(spacing: 30) {
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
                    
                    // Main Controls
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
                    
                    // Theme Picker & Settings
                    VStack(spacing: 15) {
                        ThemePickerView()
                        
                        // Toggles (Smaller, underneath)
                        HStack(spacing: 20) {
                             Toggle("Announce", isOn: $timerManager.announceTime)
                                 .labelsHidden()
                                 .toggleStyle(SwitchToggleStyle(tint: selectedTheme.accentColor))
                                 .overlay(Text("Spk").font(.caption).offset(y: 25))
                             
                             Toggle("Loop", isOn: $timerManager.loopAlarm)
                                 .labelsHidden()
                                 .toggleStyle(SwitchToggleStyle(tint: selectedTheme.accentColor))
                                 .overlay(Text("Loop").font(.caption).offset(y: 25))
                        }
                        .foregroundColor(selectedTheme.secondaryTextColor)
                        .padding(.bottom, 10)
                    }
                }
                #if os(iOS)
                .padding(.bottom, 40)
                #else
                .padding(.bottom, 90) // Increased for Mac to avoid progress bar overlap
                #endif
            }
            .padding()
            
            // Edge Progress Indicator
            #if os(iOS)
            ZStack {
                // Background Track
                ContainerRelativeShape()
                    //.inset(by: 2) // Optional: fine-tune if needed, but standard shape should match
                    .stroke(selectedTheme.trackColor, lineWidth: 14)
                
                // Progress
                // Segment 1: From Top (0.75) to Right (1.0)
                ContainerRelativeShape()
                    .trim(from: 0.75, to: min(1.0, 0.75 + CGFloat(timerManager.progress)))
                    .stroke(selectedTheme.accentColor, style: StrokeStyle(lineWidth: 14, lineCap: .round, lineJoin: .round))
                    .animation(.linear(duration: 0.1), value: timerManager.progress)
                
                // Segment 2: From Right (0.0) to Top (0.75) - Handles wrap
                ContainerRelativeShape()
                    .trim(from: 0.0, to: CGFloat(max(0.0, timerManager.progress - 0.25)))
                    .stroke(selectedTheme.accentColor, style: StrokeStyle(lineWidth: 14, lineCap: .round, lineJoin: .round))
                    .animation(.linear(duration: 0.1), value: timerManager.progress)
            }
            .padding(7)
            .edgesIgnoringSafeArea(.all)
            #else
            ZStack {
                // Background Track
                RoundedRectangle(cornerRadius: 40, style: .continuous)
                    .stroke(selectedTheme.trackColor, lineWidth: 56)
                
                // Progress
                // Segment 1: From Top (0.75) to Right (1.0)
                RoundedRectangle(cornerRadius: 40, style: .continuous)
                    .trim(from: 0.75, to: min(1.0, 0.75 + CGFloat(timerManager.progress)))
                    .stroke(selectedTheme.accentColor, style: StrokeStyle(lineWidth: 56, lineCap: .round, lineJoin: .round))
                    .animation(.linear(duration: 0.1), value: timerManager.progress)
                
                // Segment 2: From Right (0.0) to Top (0.75) - Handles wrap
                RoundedRectangle(cornerRadius: 40, style: .continuous)
                    .trim(from: 0.0, to: CGFloat(max(0.0, timerManager.progress - 0.25)))
                    .stroke(selectedTheme.accentColor, style: StrokeStyle(lineWidth: 56, lineCap: .round, lineJoin: .round))
                    .animation(.linear(duration: 0.1), value: timerManager.progress)
            }
            .padding(30) // Increased padding further to accommodate thicker stroke on Mac
            #endif
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
