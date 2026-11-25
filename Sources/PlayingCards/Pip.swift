//
//  Pip.swift
//  PlayingCards
//
//  Created by Tomas Gallucci on 11/15/26.
//


public enum Pip: CaseIterable, CustomStringConvertible, Equatable, Hashable, Comparable, Codable {
    case two, three, four, five, six, seven, eight, nine, ten, jack, queen, king, ace
    
        // Returns the standard "high" value
    public var highValue: Int {
        switch self {
        case .two: return 2
        case .three: return 3
        case .four: return 4
        case .five: return 5
        case .six: return 6
        case .seven: return 7
        case .eight: return 8
        case .nine: return 9
        case .ten: return 10
        case .jack: return 11
        case .queen: return 12
        case .king: return 13
        case .ace: return 14
        }
    }
    
        // Returns the "low" value (Ace is 1)
    public var lowValue: Int {
        if self == .ace { return 1 }
        return highValue
    }
    
    public static func < (lhs: Pip, rhs: Pip) -> Bool {
        return lhs.highValue < rhs.highValue
    }
    
    public var description: String {
        switch self {
        case .ace: return "A"
        case .jack: return "J"
        case .queen: return "Q"
        case .king: return "K"
        default: return String(self.highValue)
        }
    }
}
