//
//  DiscardPile.swift
//  PlayingCards
//
//  Created by Tomas Gallucci on 11/15/26.
//

public struct DiscardPile: Equatable, Hashable, Codable {
    private var cards = [Card]()
    
    public var count: Int {
        return cards.count
    }
    
    public init() {}
    
    public mutating func push(_ card: Card) {
        cards.append(card)
    }
    
    public mutating func pop() -> Card? {
        return cards.popLast()
    }
    
    /// Removes and returns all cards except the top one.
    public mutating func flush() -> [Card]? {
        guard cards.count > 1 else { return nil }
        
        let topCard = cards.removeLast()
        let flushedCards = cards
        
        cards = [topCard]
        
        return flushedCards
    }
    
    public mutating func reset() {
        cards = []
    }
}
