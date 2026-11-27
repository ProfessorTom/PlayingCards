//
//  Card.swift
//  PlayingCards
//
//  Created by Tomas Gallucci on 11/15/26.
//


public enum Card: CustomStringConvertible, Equatable, Hashable, Codable, Sendable {
    case standard(pip: Pip, suit: Suit)
    case joker(JokerType)
    
    public var description: String {
        switch self {
        case .standard(let pip, let suit):
            return "\(pip)\(suit)"
        case .joker(let type):
            return type == .big ? "Big 🤡" : "Little 🤡"
        }
    }
    
    public var pip: Pip? {
        switch self {
        case .standard(let pip, _):
            return pip
        case .joker:
            return nil
        }
    }
    
    public var suit: Suit? {
        switch self {
        case .standard(_, let suit):
            return suit
        case .joker:
            return nil
        }
    }
}

