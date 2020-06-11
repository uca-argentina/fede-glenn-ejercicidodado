Class {
	#name : #Game,
	#superclass : #Object,
	#instVars : [
		'spaces',
		'players',
		'dice',
		'laps',
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

{ #category : #action }
Game >> OLDSkipToNextTurn [
  players addLast: (players removeFirst)
	
]

{ #category : #action }
Game >> advance: aPlayer [
	| rolled effect |
	rolled := dice roll.
	effect := self selectEffect.
	(self isAboutToWin: aPlayer havingRolled: rolled)
		ifTrue: [ aPlayer move: spaces - aPlayer position ]
		ifFalse: [ aPlayer move: rolled ].
	effect applyTo: players.
	self OLDSkipToNextTurn
]

{ #category : #action }
Game >> assertIsTurnOf: aPlayer [
	(self isTurnOf: aPlayer)
		ifFalse: [ TurnError signal: 'This is not the player turn' ]
]

{ #category : #information }
Game >> boardLaps [
	^ laps
]

{ #category : #information }
Game >> boardSpaces [
	^ spaces
]

{ #category : #state }
Game >> hasAWinner [
	^ positionTracker isThereAWinner
]

{ #category : #state }
Game >> hasFinished [
	^players anySatisfy: [ :aPlayer | aPlayer position >= spaces ]

	
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
Game >> initializeWithSpaces: amountOfSpaces Dice: aDie Players: somePlayers Laps: aLapNumber Effects: someEffect [
	players := somePlayers asOrderedCollection.
	self verifyAndSetSpaces: amountOfSpaces.
	dice := aDie.
	laps := aLapNumber.
	self verifyAndSetEffectsProbability: someEffect.
	somePlayers do: [ :aPlayer | aPlayer addGame: self ]
]

{ #category : #action }
Game >> isAboutToWin: aPlayer havingRolled: result [
	^ aPlayer currentLap = laps and: (result + aPlayer position > spaces)
]

{ #category : #testing }
Game >> isTurnOf: aPlayer [
	^ (players first) = aPlayer
]

{ #category : #information }
Game >> oldScoreBoard [
	^ players
		sort: [ :aPlayer :otherPlayer | 
			(aPlayer position + (aPlayer currentLap * spaces))
				>= (otherPlayer position + (otherPlayer currentLap * spaces)) ]
]

{ #category : #action }
Game >> play: aPlayer [
	turnManager isAllowedToPlay:  aPlayer.
	self playTurn: aPlayer.
]

{ #category : #play }
Game >> playTurn: aPlayer [ 
	| rolled |
	rolled := dice roll.
	positionTracker move: aPlayer havingRolled: rolled.
	turnManager alreadyPlayed: aPlayer.

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

{ #category : #initialization }
Game >> verifyAndSetSpaces: amountOfSpaces [
	amountOfSpaces < 0
		ifTrue: [ CreationError
				signal: 'You cannot create a board with a negative values' ]
		ifFalse: [ spaces := amountOfSpaces ]
]

{ #category : #state }
Game >> winner [
	^ players
		detect: [ :aPlayer | (aPlayer currentLap = laps) and: (aPlayer position = spaces) ]
]
