Class {
	#name : #CardManager,
	#superclass : #Object,
	#instVars : [
		'playerHands'
	],
	#classInstVars : [
		'playerHands'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
CardManager class >> dealCardsTo: aCollectionOfPlayers with: aCard [
	^self new initializeWithPlayers: aCollectionOfPlayers cards: aCard
]

{ #category : #accessig }
CardManager >> checkHandOf: aPlayer [ 
	^playerHands at: aPlayer
]

{ #category : #initialization }
CardManager >> initializeWithPlayers: aCollectionOfPlayers cards: aCard [ 
	| hand |
	playerHands := Dictionary new.
	hand := OrderedCollection new.
	hand add: aCard.
	hand add: aCard.
	aCollectionOfPlayers
		do: [ :aPlayer | playerHands add: aPlayer -> hand ]
]
