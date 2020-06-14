Class {
	#name : #CardManager,
	#superclass : #Object,
	#instVars : [
		'playerHands',
		'deckOfCards'
	],
	#classInstVars : [
		'playerHands'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
CardManager class >> dealCardsTo: aCollectionOfPlayers with: aCollectionOfCards [
	^self new initializeWithPlayers: aCollectionOfPlayers cards: aCollectionOfCards 
]

{ #category : #accessig }
CardManager >> checkHandOf: aPlayer [ 
	^playerHands at: aPlayer
]

{ #category : #action }
CardManager >> drawCard: aPlayer [ 
	(self checkHandOf: aPlayer) add: (deckOfCards drawCard).


]

{ #category : #initialization }
CardManager >> initializeWithPlayers: aCollectionOfPlayers cards: aDeckOfCards [
	| hand randomCard |
	deckOfCards := aDeckOfCards.
	playerHands := Dictionary new.
	hand := OrderedCollection new.
	hand add: aDeckOfCards drawCard.
	hand add: aDeckOfCards drawCard.
	aCollectionOfPlayers
		do: [ :aPlayer | playerHands add: aPlayer -> hand ]
]

{ #category : #playing }
CardManager >> utilizeCard: aCard from: aPlayer [ 
	(self checkHandOf: aPlayer) remove: aCard
]
