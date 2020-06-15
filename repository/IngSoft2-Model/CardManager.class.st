Class {
	#name : #CardManager,
	#superclass : #Object,
	#instVars : [
		'playerHands',
		'deckOfCards',
		'permanentCardsPlayed',
		'lastPlayed'
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

{ #category : #'as yet unclassified' }
CardManager >> SutilizeCard: aCard from: aPlayer to: targetedPlayer [
	self isCard: aCard inHandOf: aPlayer.
	(self checkHandOf: aPlayer) remove: aCard.
	aCard isPermanent
		ifTrue: [ aCard target: targetedPlayer.
			permanentCardsPlayed add: aCard ]
]

{ #category : #accessing }
CardManager >> activeCardEffect [
	^permanentCardsPlayed
]

{ #category : #accessig }
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
	(self checkHandOf: aPlayer) add: (deckOfCards drawCard).


]

{ #category : #initialization }
CardManager >> initializeWithPlayers: aCollectionOfPlayers cards: aDeckOfCards [
	deckOfCards := aDeckOfCards.
	playerHands := Dictionary new.
	permanentCardsPlayed := OrderedCollection new. 
	aCollectionOfPlayers
		do: [ :aPlayer | playerHands add: aPlayer -> (self createInitialHand: aDeckOfCards) ] 
]

{ #category : #checking }
CardManager >> isCard: aCard inHandOf: aPlayer [ 
	((playerHands at: aPlayer) includes: aCard)
			ifFalse: [MissingCardError signal:'No esta en la mano del jugador']
]

{ #category : #'as yet unclassified' }
CardManager >> lastPlayedCard [
	^lastPlayed
]

{ #category : #'as yet unclassified' }
CardManager >> replayLastPermanentEffectTarget: aPlayer [ 
	permanentCardsPlayed add: ((permanentCardsPlayed last copy) target: aPlayer).
]

{ #category : #effects }
CardManager >> takePermanentEffect: aPermanentCard [  
	permanentCardsPlayed remove: aPermanentCard ifAbsent: [MissingActiveCardEffect signal:'there is no active effect targeted' ].
]

{ #category : #playing }
CardManager >> utilizeCard: aCard from: aPlayer [ 
	self utilizeCard: aCard from: aPlayer to: aPlayer
	
]

{ #category : #'card application' }
CardManager >> utilizeCard: aCard from: aPlayer to: targetedPlayer [
	self isCard: aCard inHandOf: aPlayer.
	(self checkHandOf: aPlayer) remove: aCard.
	lastPlayed := aCard.
	aCard isPermanent
		ifTrue: [ aCard target: targetedPlayer.
			 permanentCardsPlayed add: aCard ]
]
