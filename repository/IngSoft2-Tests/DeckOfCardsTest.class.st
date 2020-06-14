Class {
	#name : #DeckOfCardsTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
DeckOfCardsTest >> testDrawRandomCard [
	|deckOfCards result|
	deckOfCards := Deck withCards: (Array with: NoEffectCard new with: OverloadCard new).
	
	result := OrderedCollection new.
	
	100 timesRepeat: [ result add: (deckOfCards drawCard) ].
	self assert: (result anySatisfy:[:aCard | aCard = NoEffectCard new]).
	self assert: (result anySatisfy:[:aCard | aCard = OverloadCard new]).


]
