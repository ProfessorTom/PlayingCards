//
//  DeckTests.swift
//  PlayingCards
//
//  Created by Tomas Gallucci on 11/15/26.
//

import Testing
@testable import PlayingCards

@Suite struct DeckTests {
    struct GenerateStandard52CardsTests {
        @Test func testGenerateStandard52Cards() {
                // When
            let cards = Deck.generateStandard52Cards()
            
                // Then
            #expect(cards.count == 52)
        }
        
        @Test func testGenerateStandard52CardsWithJokers() {
                // When
            let cards = Deck.generateStandard52Cards(includeJokers: true)
            
                // Then
            #expect(cards.count == 54)
            #expect(cards.contains(.joker(.big)))
            #expect(cards.contains(.joker(.little)))
        }
        
        @Test func testAllCardsAreUnique() {
                // When
            let cards = Deck.generateStandard52Cards()
            
                // Then
                // A Set only allows unique elements. If the count matches, there are no duplicates.
            let uniqueCards = Set(cards)
            #expect(uniqueCards.count == cards.count)
        }
        
        @Test func testEverySuitAndPipIsRepresented() {
                // When
            let cards = Deck.generateStandard52Cards()
            
                // Then
                // We can verify we have 13 cards of each suit
            for suit in Suit.allCases {
                let cardsInSuit = cards.filter { card in
                    if case let .standard(_, cardSuit) = card {
                        return cardSuit == suit
                    }
                    return false
                }
                #expect(cardsInSuit.count == 13)
            }
        }
    }
}
