import SwiftUI

struct ThemePickerView: View {
    @AppStorage("selectedThemeID") private var selectedThemeID: String = Theme.standard.id
    
    var selectedTheme: Theme {
        Theme.allThemes.first(where: { $0.id == selectedThemeID }) ?? .standard
    }
    
    var body: some View {
        Menu {
            ForEach(Theme.allThemes) { theme in
                Button(action: {
                    selectedThemeID = theme.id
                }) {
                    HStack {
                        Text(theme.name)
                        if selectedThemeID == theme.id {
                            Image(systemName: "checkmark")
                        }
                    }
                }
            }
        } label: {
            Image(systemName: "paintpalette.fill")
                .foregroundColor(selectedTheme.accentColor)
                .font(.largeTitle)
                .padding()
        }
        .onChange(of: selectedThemeID) { newValue in
            print("Theme changed to: \(newValue)")
        }
    }
}

struct ThemePickerView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            ThemePickerView()
        }
    }
}
