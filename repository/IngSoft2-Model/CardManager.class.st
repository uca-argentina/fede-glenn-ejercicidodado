Class {
	#name : #CardManager,
	#superclass : #Object,
	#instVars : [
		'playerHands',
		'deckOfCards',
		'permanentCardsPlayed',
		'lastPlayed',
		'discardDeck'
	],
	#classInstVars : [
		'playerHands'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
CardManager class >> dealCardsTo: aCollectionOfPlayers with: aDeck [
	^self new initializeWithPlayers: aCollectionOfPlayers cards: aDeck 
]

{ #category : #accessing }
CardManager >> activeCardEffect [
	^permanentCardsPlayed
]

{ #category : #accessing }
CardManager >> checkHandOf: aPlayer [ 
	^playerHands at: aPlayer
]

{ #category : #initialization }
CardManager >> createInitialHand: aDeckOfCards [
	| hand |
	hand := OrderedCollection new.
	hand add: aDeckOfCards drawCard.
	hand add: aDeckOfCards drawCard.
	^ hand
]

{ #category : #action }
CardManager >> drawCardFor: aPlayer [
	self isDeckEmpty
		ifTrue: [ discardDeck isEmpty
				ifFalse: [ deckOfCards mixWith: discardDeck.
							  (self checkHandOf: aPlayer) add: deckOfCards drawCard ] ]
		ifFalse: [ (self checkHandOf: aPlayer) add: deckOfCards drawCard ]
]

{ #category : #initialization }
CardManager >> initializeWithPlayers: aCollectionOfPlayers cards: aDeckOfCards [
	deckOfCards := aDeckOfCards.
	discardDeck := Deck with: { }.
	playerHands := Dictionary new.
	permanentCardsPlayed := OrderedCollection new. 
	aCollectionOfPlayers
		do: [ :aPlayer | playerHands add: aPlayer -> (self createInitialHand: aDeckOfCards) ] 
]

{ #category : #accessing }
CardManager >> isCard: aCard inHandOf: aPlayer [ 
	((playerHands at: aPlayer) includes: aCard)
			ifFalse: [EmptyDeckError  signal:'Card is not in players hand']
]

{ #category : #information }
CardManager >> isDeckEmpty [
	^ deckOfCards isEmpty
]

{ #category : #accessing }
CardManager >> lastPlayedCard [
	^lastPlayed
]

{ #category : #effects }
CardManager >> removeActiveCard: aPermanentCard [  
	permanentCardsPlayed remove: aPermanentCard ifAbsent: [MissingActiveCardEffect signal:'there is no active effect targeted' ].
]

{ #category : #action }
CardManager >> replayLastPermanentEffectTarget: aPlayer [ 
	permanentCardsPlayed add: ((permanentCardsPlayed last copy) target: aPlayer).
]

{ #category : #action }
CardManager >> take: cardPlayed from: aPlayer [
	|playedCard|
	playedCard := (self checkHandOf: aPlayer) remove: cardPlayed.
	discardDeck putAtBottom: playedCard.
	
]

{ #category : #action }
CardManager >> utilizeCard: aCard from: aPlayer [ 
	self utilizeCard: aCard from: aPlayer to: aPlayer
	
]

{ #category : #action }
CardManager >> utilizeCard: aCard from: aPlayer to: targetedPlayer [
	self isCard: aCard inHandOf: aPlayer.
	self take: aCard from: aPlayer.
	lastPlayed := aCard.
	aCard isPermanent
		ifFalse: [ ^ self ].
	aCard target: targetedPlayer.
	permanentCardsPlayed add: aCard
]
