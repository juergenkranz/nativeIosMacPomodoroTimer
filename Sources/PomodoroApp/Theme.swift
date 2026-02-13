import SwiftUI

struct Theme: Identifiable, Hashable {
    let id: String
    let name: String
    let backgroundColor: Color
    let primaryTextColor: Color
    let secondaryTextColor: Color
    let accentColor: Color
    let buttonBackgroundColor: Color
    let trackColor: Color
    
    // Default Theme (Current)
    static let standard = Theme(
        id: "standard",
        name: "Default",
        backgroundColor: .black,
        primaryTextColor: .white,
        secondaryTextColor: .white,
        accentColor: .orange,
        buttonBackgroundColor: .gray, // Or dynamic handling for active/inactive
        trackColor: Color.gray.opacity(0.3)
    )
    
    // Neon Theme
    static let neon = Theme(
        id: "neon",
        name: "Neon",
        backgroundColor: Color(red: 0.05, green: 0.05, blue: 0.1), // Very dark blue/black
        primaryTextColor: Color(red: 1.0, green: 0.0, blue: 0.8), // Hot Pink
        secondaryTextColor: Color(red: 0.0, green: 1.0, blue: 1.0), // Cyan
        accentColor: Color(red: 0.0, green: 1.0, blue: 0.0), // Neon Green
        buttonBackgroundColor: Color(red: 0.2, green: 0.2, blue: 0.2),
        trackColor: Color(red: 0.1, green: 0.1, blue: 0.3)
    )
    
    // Matrix Theme
    static let matrix = Theme(
        id: "matrix",
        name: "Matrix",
        backgroundColor: .black,
        primaryTextColor: Color(red: 0.0, green: 1.0, blue: 0.2), // Bright Green
        secondaryTextColor: Color(red: 0.0, green: 0.6, blue: 0.1), // Darker Green
        accentColor: Color(red: 0.8, green: 1.0, blue: 0.8), // Pale Green
        buttonBackgroundColor: Color(red: 0.0, green: 0.2, blue: 0.0), // Very Dark Green
        trackColor: Color(red: 0.0, green: 0.3, blue: 0.0)
    )

    // Cyberpunk Theme
    static let cyberpunk = Theme(
        id: "cyberpunk",
        name: "Cyberpunk",
        backgroundColor: Color(red: 0.05, green: 0.05, blue: 0.1), // Almost Black
        primaryTextColor: Color(red: 1.0, green: 0.9, blue: 0.1), // Electric Yellow
        secondaryTextColor: Color(red: 0.0, green: 0.8, blue: 1.0), // Electric Blue
        accentColor: Color(red: 1.0, green: 0.0, blue: 0.3), // Neon Red/Pink
        buttonBackgroundColor: Color(red: 0.2, green: 0.2, blue: 0.3),
        trackColor: Color(red: 0.3, green: 0.0, blue: 0.3)
    )

    // Vaporwave Theme
    static let vaporwave = Theme(
        id: "vaporwave",
        name: "Vaporwave",
        backgroundColor: Color(red: 0.1, green: 0.0, blue: 0.2), // Deep Purple
        primaryTextColor: Color(red: 0.0, green: 1.0, blue: 1.0), // Cyan
        secondaryTextColor: Color(red: 1.0, green: 0.6, blue: 0.8), // Pink
        accentColor: Color(red: 1.0, green: 0.4, blue: 0.8), // Hot Pink
        buttonBackgroundColor: Color(red: 0.2, green: 0.1, blue: 0.3),
        trackColor: Color(red: 0.4, green: 0.2, blue: 0.5)
    )
    
    // Sunset Theme
    static let sunset = Theme(
        id: "sunset",
        name: "Sunset",
        backgroundColor: Color(red: 0.2, green: 0.05, blue: 0.1), // Dark Red/Brown
        primaryTextColor: Color(red: 1.0, green: 0.8, blue: 0.4), // Warm Orange
        secondaryTextColor: Color(red: 1.0, green: 0.4, blue: 0.4), // Salmon
        accentColor: Color(red: 1.0, green: 0.6, blue: 0.0), // Gold
        buttonBackgroundColor: Color(red: 0.3, green: 0.1, blue: 0.1),
        trackColor: Color(red: 0.4, green: 0.2, blue: 0.2)
    )
    
    // Cotton Candy Theme
    static let cottonCandy = Theme(
        id: "cottonCandy",
        name: "Cotton Candy",
        backgroundColor: Color(red: 0.1, green: 0.1, blue: 0.15), // Dark Blueish Grey (for contrast)
        primaryTextColor: Color(red: 1.0, green: 0.6, blue: 0.8), // Pink
        secondaryTextColor: Color(red: 0.6, green: 0.8, blue: 1.0), // Light Blue
        accentColor: Color(red: 0.4, green: 0.9, blue: 1.0), // Cyan/Blue
        buttonBackgroundColor: Color(red: 0.2, green: 0.2, blue: 0.3),
        trackColor: Color(red: 0.3, green: 0.2, blue: 0.4)
    )
    
    // 80s Theme (Tweaked)
    static let retro80s = Theme(
        id: "retro80s",
        name: "80s",
        backgroundColor: Color(red: 0.15, green: 0.05, blue: 0.25), // Darker Purple for contrast
        primaryTextColor: Color(red: 1.0, green: 0.9, blue: 0.1), // Bright Yellow
        secondaryTextColor: Color(red: 0.0, green: 0.9, blue: 0.9), // Bright Cyan
        accentColor: Color(red: 1.0, green: 0.2, blue: 0.6), // Hot Pink
        buttonBackgroundColor: Color(red: 0.3, green: 0.1, blue: 0.4),
        trackColor: Color(red: 0.5, green: 0.2, blue: 0.6)
    )
    
    static let allThemes = [standard, neon, retro80s, matrix, cyberpunk, vaporwave, sunset, cottonCandy]
}
