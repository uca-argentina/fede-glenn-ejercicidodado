Class {
	#name : #Game,
	#superclass : #Object,
	#instVars : [
		'dice',
		'positionTracker',
		'turnManager',
		'cardManager'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Game class >> withBoard: aBoard Dice: dice Players: aCollectionOfPlayers cards: aCollectionOfCards [ 
	^self new initializeWithBoard: aBoard dice: dice  players: aCollectionOfPlayers cards: aCollectionOfCards 
]

{ #category : #initialization }
Game class >> withBoard: aBoard dice: aDie players: somePlayers [ 
	^ self new
		initializeWithBoard: aBoard
		dice: aDie
		players: somePlayers.
]

{ #category : #'effect application' }
Game >> applyAtomicBombEffect [
	positionTracker moveAllToStart.
]

{ #category : #'effect application' }
Game >> applyDrawCardEffect [
	cardManager drawCard: (turnManager currentTurnPlayer)
]

{ #category : #'effect application' }
Game >> applyMoonWalkEffect: aMoonWalkEffect [
	turnManager allPlayersButActual
		do: [ :aPlayer | 
			positionTracker
				moveBackwards: aPlayer
				spaces: aMoonWalkEffect backingSpaces ]
]

{ #category : #'effect application' }
Game >> applySpeedUpEffect [
	positionTracker move: (turnManager currentTurnPlayer) havingRolled: 4.
]

{ #category : #'effect application' }
Game >> applyWormHoleEffect [
	positionTracker moveBackwards: turnManager currentTurnPlayer spaces: 4.
]

{ #category : #accessing }
Game >> checkHandOf: aPlayer [ 
	^cardManager checkHandOf: aPlayer
]

{ #category : #state }
Game >> hasAWinner [
	^ positionTracker isThereAWinner
]

{ #category : #accessing }
Game >> inWhichPositionIs: aPlayer [ 
	^positionTracker inWhichPositionIs: aPlayer 
]

{ #category : #initializing }
Game >> initializeWithBoard: aBoard dice: aDice players: somePlayers [ 
	dice := aDice.
	positionTracker := PositionTracker withBoard: aBoard Players: somePlayers.
	turnManager := TurnManager organize: somePlayers asOrderedCollection.
]

{ #category : #initialization }
Game >> initializeWithBoard: aBoard dice: aDice players: aCollectionOfPlayers cards: aCollectionOfCards [ 
	dice := aDice.
	positionTracker := PositionTracker withBoard: aBoard Players: aCollectionOfPlayers.
	turnManager := TurnManager organize: aCollectionOfPlayers asOrderedCollection.
	cardManager := CardManager dealCardsTo: aCollectionOfPlayers with: aCollectionOfCards. 
]

{ #category : #action }
Game >> play: aPlayer [
	turnManager isTurnOf:  aPlayer.
	self playTurn: aPlayer. 
	turnManager alreadyPlayed: aPlayer.
]

{ #category : #playing }
Game >> playCard: aCard from: aPlayer [ 
	cardManager utilizeCard: aCard from: aPlayer
]

{ #category : #play }
Game >> playTurn: aPlayer [ 
	| rolled currentLocker|
	rolled := dice roll.
	positionTracker move: aPlayer havingRolled: rolled.
	currentLocker := positionTracker inWhichPositionIs: aPlayer.
	currentLocker effect applyTo: self.


]

{ #category : #ranking }
Game >> rankOf: aPlayer [ 
	^positionTracker getPlayersInOrderByLocker indexOf: aPlayer.
]

{ #category : #ranking }
Game >> scoreBoard [
	^positionTracker getPlayersInOrderByLocker  
]
