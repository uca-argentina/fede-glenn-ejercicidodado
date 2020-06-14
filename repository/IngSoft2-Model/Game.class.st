Class {
	#name : #Game,
	#superclass : #Object,
	#instVars : [
		'dice',
		'effects',
		'board',
		'positionTracker',
		'turnManager'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Game class >> withBoard: aBoard Dice: aDie Players: somePlayers [ 
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

{ #category : #action }
Game >> play: aPlayer [
	turnManager isTurnOf:  aPlayer.
	self playTurn: aPlayer. 
	turnManager alreadyPlayed: aPlayer.
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
