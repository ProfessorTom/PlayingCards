//
//  Deck.swift
//  PlayingCards
//
//  Created by Tomas Gallucci on 11/15/26.
//


public struct Deck: Equatable, Hashable, Codable {
    public static func generateStandard52Cards(includeJokers: Bool = false) -> [Card] {
        var cards: [Card] = []
        cards.reserveCapacity(52)
        
        for suit in Suit.allCases {
            for pip in Pip.allCases {
                cards.append(Card.standard(pip: pip, suit: suit))
            }
        }
        
        if includeJokers {
            cards.append(.joker(.big))
            cards.append(.joker(.little))
        }
        
        return cards
    }
}
