//
//  Test.swift
//  PlayingCards
//
//  Created by Tomas Gallucci on 11/15/26.
//

import Testing
@testable import PlayingCards

@Suite struct ShoeTests {
    struct intializationTests {
        struct defaults {
            @Test func numberOfDecks() {
                let shoe = Shoe()
                #expect(shoe.numberOfDecks == 1)
            }
            
            @Test func includeJokers() {
                let shoe = Shoe()
                #expect(shoe.includeJokers == false)
            }
            
            @Test func numberOfCardsInShoe() {
                let shoe = Shoe()
                #expect(shoe.numberOfCardsLeftInDeck == 52)
            }
        }
        
        struct refill {
            @Test func existingCardsStayInPlace() {
                var shoe = Shoe(numberOfDecks: 0, includeJokers: false, shuffler: { cards in
                    return
                })
                
                    // 1. Put an "existing" card in the shoe
                let existingCard = Card.standard(pip: .king, suit: .hearts)
                shoe.refill(with: [existingCard], shuffle: false)
                
                    // 2. Refill with new cards
                let refillCards = [
                    Card.joker(.big),
                    Card.standard(pip: .ace, suit: .spades),
                    Card.joker(.little)
                ]
                shoe.refill(with: refillCards, shuffle: false)
                
                    // 3. Create your expected shoe
                var expectedShoe = Shoe(numberOfDecks: 0)
                
                    // Because of how your refill works (inserting at 0),
                    // the refillCards go to the bottom, and the existingCard stays on top.
                expectedShoe.refill(with: [existingCard], shuffle: false)
                expectedShoe.refill(with: refillCards, shuffle: false)
                
                    // 4. Compare them!
                #expect(shoe == expectedShoe)
            }
            
            @Test func testRefillActuallyShuffles() {
                var shoe = Shoe(numberOfDecks: 0)
                let originalCards = [
                    Card.standard(pip: .ace, suit: .spades),
                    Card.standard(pip: .king, suit: .hearts)
                ]
                
                var shuffleWasCalled = false
                
                shoe.refill(with: originalCards, shuffle: true) { cards in
                    shuffleWasCalled = true
                    cards.reverse() // Predictable "shuffle"
                }
                
                #expect(shuffleWasCalled == true)
                
                // we insert at the end of the list, so it reverses the reverse
                // when we internally pop off the end of the array
                let expectedCards = [
                    Card.standard(pip: .ace, suit: .spades),
                    Card.standard(pip: .king, suit: .hearts),
                ]
                
                let actualCards = [
                    shoe.drawCardFromShoe()!,
                    shoe.drawCardFromShoe()!
                ]
                #expect(actualCards == expectedCards)
            }
        }
        
        struct reset {
            @Test func reset() {
                let twoDeckCount = 52 * 2
                var shoe = Shoe(numberOfDecks: 2, includeJokers: false, shuffler: { cards in
                    return
                })
                #expect(shoe.numberOfCardsLeftInDeck == twoDeckCount)
                
                (1...3).forEach { _ in
                    _ = shoe.dealCard()
                }
                #expect(shoe.numberOfCardsLeftInDeck == (twoDeckCount - 3))
                
                let expectedShoe = Shoe(numberOfDecks: 2, includeJokers: false, shuffler: { cards in
                    return
                })
                shoe.reset()
                #expect(shoe == expectedShoe)
            }
        }
    }
}
