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

{ #category : #'instance creation' }
Game class >> withSpaces: anInteger withDice: aDie withPlayers: somePlayers withLaps: aLapNumber [
	^ self new
		initializeWithSpaces: anInteger
		Dice: aDie
		Players: somePlayers
		Laps: aLapNumber
		Effects: (Array with: (NoEffect withProbability: 1)).
]

{ #category : #'instance creation' }
Game class >> withSpaces: anInteger withDice: aDie withPlayers: somePlayers withLaps: aLapNumber withEffect: anEffect [ 
	^ self new
		initializeWithSpaces: anInteger
		Dice: aDie
		Players: somePlayers
		Laps: aLapNumber
		Effects: anEffect.
		
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

{ #category : #action }
Game >> assertIsTurnOf: aPlayer [
	(self isTurnOf: aPlayer)
		ifFalse: [ TurnError signal: 'This is not the player turn' ]
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
	turnManager isAllowedToPlay:  aPlayer.
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

{ #category : #selection }
Game >> selectEffect [
	| probability base |
	probability := Random new next.
	base := 0.
	^ effects
		detect: [ :anEffect | 
			base := base + anEffect probability.
			probability <= anEffect probability ]
		ifFound: [ :anEffect | anEffect ]
		ifNone: [ NoEffect withProbability: 1 ]
]

{ #category : #initialization }
Game >> verifyAndSetEffectsProbability: anEffect [
	| totalProbability |
	totalProbability := anEffect
		sum: [ :oneEffect | oneEffect probability ].
	effects := anEffect asOrderedCollection.
	totalProbability > 1
		ifTrue: [ CreationError
				signal: 'The total effect probability percentage is more than 100%' ]
		ifFalse: [ effects add: (NoEffect withProbability: 1 - 0.4) ]
]
