Class {
	#name : #DeckOfCardsTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #setup }
DeckOfCardsTest >> drawOneHundredCardsFrom: aDeck [ 
	| result |
	result := OrderedCollection new.
	100 timesRepeat: [ result add: aDeck drawCard ].
	^ result
]

{ #category : #tests }
DeckOfCardsTest >> testDrawCardsWithUniformDistribution [
	|deckOfCards result|
	deckOfCards := Deck withCards: (Array with: NoEffectCard new with: OverloadCard new).
	
	
	result := self drawOneHundredCardsFrom: deckOfCards.
	self assert: (result anySatisfy:[:aCard | aCard = NoEffectCard new]).
	self assert: (result anySatisfy:[:aCard | aCard = OverloadCard new]).


]
