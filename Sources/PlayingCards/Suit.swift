//
//  Suit.swift
//  PlayingCards
//
//  Created by Tomas Gallucci on 11/15/26.
//


public enum Suit: String, CaseIterable, CustomStringConvertible, Equatable, Hashable, Codable, Sendable {
    case hearts, diamonds, clubs, spades
    
    public var description: String {
        switch self {
        case .hearts: return "♥️"
        case .diamonds: return "♦️"
        case .clubs: return "♣️"
        case .spades: return "♠️"
        }
    }
}
