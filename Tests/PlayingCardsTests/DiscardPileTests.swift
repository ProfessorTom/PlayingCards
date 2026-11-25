//
//  DiscardPileTests.swift
//  PlayingCards
//
//  Created by Tomas Gallucci on 11/15/26.
//


import Testing
@testable import PlayingCards

//@Test func example() async throws {
//    // Write your test here and use APIs like `#expect(...)` to check expected conditions.
//    // Swift Testing Documentation
//    // https://developer.apple.com/documentation/testing
//}

@Suite struct DiscardPileTests {
    struct FlushTests {
        @Test func flushReturnsDiscardPileMinusTopCard() {
            var discardPile = DiscardPile()
            
            discardPile.push(Card.standard(pip: .ace, suit: .clubs))
            discardPile.push(Card.standard(pip: .two, suit: .hearts))
            discardPile.push(Card.standard(pip: .three, suit: .diamonds))
            
            let expectedCardArray = [
                Card.standard(pip: .ace, suit: .clubs),
                Card.standard(pip: .two, suit: .hearts)
            ]
            let actualCardArray = discardPile.flush()
            #expect(actualCardArray == expectedCardArray)
        }
        
        @Test func flushLeavesDiscardPileWithTopCardOnly() {
            var discardPile = DiscardPile()
            var expectedDiscardPile = DiscardPile()
            #expect(discardPile == expectedDiscardPile)
            
            let threeOfDiamonds = Card.standard(pip: .three, suit: .diamonds)
            
            discardPile.push(Card.standard(pip: .ace, suit: .clubs))
            discardPile.push(Card.standard(pip: .two, suit: .hearts))
            discardPile.push(threeOfDiamonds)
            
            _ = discardPile.flush()
            expectedDiscardPile.push(threeOfDiamonds)
            #expect(discardPile == expectedDiscardPile)
        }
        
        @Test func flushWithLessThanTwoCardsReturnsEmptyArray() {
            var discardPile = DiscardPile()
            let flushedCards = discardPile.flush()
            #expect(flushedCards == nil)
        }
    }
    
    struct resetTests {
        @Test func reset() {
            var discardPile = DiscardPile()
            let expectedDiscardPile = DiscardPile()
            #expect(discardPile == expectedDiscardPile)
            
            discardPile.push(Card.joker(.little))
            discardPile.push(Card.standard(pip: .eight, suit: .spades))
            
            discardPile.reset()
            #expect(discardPile == expectedDiscardPile)
        }
    }
    
    struct popTests {
        @Test func popReturnsMostRecentlyPushedCard() {
            var discardPile = DiscardPile()
            var expectedDiscardPile = DiscardPile()
            #expect(discardPile == expectedDiscardPile)
            
            let expectedCard = Card.standard(pip: .eight, suit: .spades)
            let littleJoker = Card.joker(.little)
                        
            discardPile.push(littleJoker)
            discardPile.push(expectedCard)
            
            let card = discardPile.pop()
            #expect(card == expectedCard)
            
            expectedDiscardPile.push(littleJoker)
            #expect(discardPile == expectedDiscardPile)
        }
        
        @Test func popReturnsNilWhenDiscardPileIsEmpty() {
            var discardPile = DiscardPile()
            let expectedDiscardPile = DiscardPile()
            #expect(discardPile == expectedDiscardPile)
            
            
            let card = discardPile.pop()
            #expect(card == nil)
            #expect(discardPile == expectedDiscardPile)
        }
    }
}
