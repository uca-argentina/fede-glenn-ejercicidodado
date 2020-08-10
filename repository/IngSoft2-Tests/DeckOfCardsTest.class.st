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
		getShuffledCollection: result
		size: amount
]

{ #category : #tests }
DeckOfCardsTest >> testCannotMixWithEmptyDeck [
	| cardDistribuiton deckOfCards anotherDeck|
	cardDistribuiton := self elements: { OverloadCard new } probability: { (1) } amount: 10.
	
	deckOfCards := Deck with: cardDistribuiton.
	anotherDeck := Deck with: {}.
	
	self
		should: [	deckOfCards mixWith: anotherDeck.]
		raise: EmptyDeckError
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
		assert: ((result count: [ :card | NoEffectCard new = card ]) between: 30 and: 55).
	self
		assert: ((result count: [ :card | OverloadCard new = card ]) between: 45 and: 75). 
]

{ #category : #tests }
DeckOfCardsTest >> testDrawFiniteAmountOrCards [
	| cardDistribuiton deckOfCards result |
	cardDistribuiton := self elements: { NoEffectCard new . OverloadCard new } probability: { (0.5) . (0.5) } amount: 10.
	deckOfCards := Deck with: cardDistribuiton.
	result := self draw: 10 from: deckOfCards.
	self assert: result size equals: 10.
	self should: [ deckOfCards drawCard ] raise: EmptyDeckError
]

{ #category : #tests }
DeckOfCardsTest >> testMixADeckWithAnother [
	| cardDistribuiton deckOfCards anotherDeck anotherCardDistribuiton|
	cardDistribuiton := self elements: { OverloadCard new } probability: { (1) } amount: 10.
	anotherCardDistribuiton := self elements: { NoEffectCard new } probability: { (1) } amount: 10.
	
	deckOfCards := Deck with: cardDistribuiton.
	anotherDeck := Deck with: anotherCardDistribuiton.
	
	deckOfCards mixWith: anotherDeck.

	self assert: deckOfCards countCards equals: 20.
	self assert: anotherDeck countCards equals: 0.
]
