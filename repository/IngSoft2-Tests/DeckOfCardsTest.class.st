Class {
	#name : #DeckOfCardsTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #drawing }
DeckOfCardsTest >> draw: amount from: aDeck [ 
	| result |
	result := OrderedCollection new.
	amount timesRepeat: [ result add: aDeck drawCard ].
	^ result
]

{ #category : #probability }
DeckOfCardsTest >> elements: elements probability: probabilities amount: amount [
	| result index |
	result := OrderedCollection new.
	index := 1.
	elements size
		timesRepeat: [ result
				add:
					(ProbabilityWrapper
						with: (elements at: index)
						probability: (probabilities at: index)).
			index := index + 1 ].
	^ ProbabilityDistributor new
		createShuffledCollection: result
		size: amount
]

{ #category : #tests }
DeckOfCardsTest >> testDrawCardsWithUniformDistribution [
	| deckOfCards result cardDistribution |
	cardDistribution := self
		elements:
			{NoEffectCard new.
			OverloadCard new}
		probability: {0.4 . 0.6}
		amount: 100.
	deckOfCards := Deck with: cardDistribution.
	result := self draw: 100 from: deckOfCards.
	self
		assert: (result count: [ :card | NoEffectCard new = card ])
		equals: 40.
	self
		assert: (result count: [ :card | OverloadCard new = card ])
		equals: 60
]

{ #category : #tests }
DeckOfCardsTest >> testDrawFiniteAmountOrCards [
	| cardDistribuiton deckOfCards result |
	cardDistribuiton := self elements: { NoEffectCard new . OverloadCard new } probability: { (0.5) . (0.5) } amount: 10.
	deckOfCards := Deck with: cardDistribuiton.
	result := self draw: 10 from: deckOfCards.
	self assert: result size equals: 10.
	self should: [ deckOfCards drawCard ] raise: MissingCardError
]

{ #category : #tests }
DeckOfCardsTest >> testMergeAnEmptyDeckWithAnother [
	| cardDistribuiton deckOfCards emptyDeck |
	cardDistribuiton := self elements: { NoEffectCard new . OverloadCard new } probability: { (0.5) . (0.5) } amount: 10.
	deckOfCards := Deck with: cardDistribuiton.
	emptyDeck := Deck with: {}.
	
	emptyDeck shuffleWith: deckOfCards.

	self assert: emptyDeck cardsLeft equals: 10.
	self assert: deckOfCards cardsLeft equals: 0.
]
