//
//  Shoe.swift
//  PlayingCards
//
//  Created by Tomas Gallucci on 11/15/26.
//

import Foundation

public struct Shoe: Equatable, Hashable, Codable {
    private var cards = [Card]()
    public var numberOfCardsLeftInDeck: Int {
        return cards.count
    }
    public var isEmpty: Bool {
        return numberOfCardsLeftInDeck == 0
    }
    
    public let numberOfDecks: Int
    public let includeJokers: Bool
    
    private let shuffler: (inout [Card]) -> Void
    
        // MARK: - init
    public init(numberOfDecks: Int = 1,
                includeJokers: Bool = false,
                shuffler: @escaping (inout [Card]) -> Void = { $0.shuffle() }) {
        self.numberOfDecks = numberOfDecks
        self.includeJokers = includeJokers
        self.shuffler = shuffler
        
        reset()
    }
    
        // MARK: - Codeable support functions
    enum CodingKeys: String, CodingKey {
        case cards
        case numberOfDecks
        case includeJokers
    }
    
        // Custom init to load the data
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.cards = try container.decode([Card].self, forKey: .cards)
        self.numberOfDecks = try container.decode(Int.self, forKey: .numberOfDecks)
        self.includeJokers = try container.decode(Bool.self, forKey: .includeJokers)
        
            // Since we can't save a closure, we assign the default shuffler when loading
            // and it's not a great loss because the reson we take a shuffler is to do
            // dependency injection in the unit tests
        self.shuffler = { $0.shuffle() }
    }
    
        // Custom method to save the data
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(cards, forKey: .cards)
        try container.encode(numberOfDecks, forKey: .numberOfDecks)
        try container.encode(includeJokers, forKey: .includeJokers)
    }
    
        // MARK: = public API
    public mutating func refill(with newCards: [Card],
                                shuffle: Bool = true,
                                shuffler: (inout [Card]) -> Void = { $0.shuffle()}) {
        var cardsToAdd = newCards
        
        if shuffle {
            shuffler(&cardsToAdd)
        }
        
        // Insert at the beginning (the bottom of the deck)
        // so the remaining cards on top are undisturbed.
        self.cards.insert(contentsOf: cardsToAdd, at: 0)
    }
    
    public mutating func dealCard() -> Card? {
        self.drawCardFromShoe()
    }
    
    public mutating func drawCardFromShoe() -> Card? {
        cards.popLast()
    }
    
    public mutating func reset() {
        cards = []
        
        for _ in 0..<numberOfDecks {
            cards.append(contentsOf: Deck.generateStandard52Cards(includeJokers: self.includeJokers))
        }
        
        shuffler(&cards)
    }
    
        // MARK: - "programming" (as in Cmmputer Science) functions
    public static func ==(lhs: Shoe, rhs: Shoe) -> Bool {
        return (lhs.cards == rhs.cards)
            && (lhs.numberOfDecks == rhs.numberOfDecks)
            && (lhs.includeJokers == rhs.includeJokers)
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(cards)
        hasher.combine(numberOfDecks)
        hasher.combine(includeJokers)
    }
}
