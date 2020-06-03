Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'spaces',
		'players',
		'dice',
		'laps',
		'effects'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Board class >> withSpaces: anInteger withDice: aDie withPlayers: somePlayers withLaps: aLapNumber [
	^ self new
		initializeWithSpaces: anInteger
		Dice: aDie
		Players: somePlayers
		Laps: aLapNumber
		Effects: (Array with: (NoEffect withProbability: 1)).
]

{ #category : #'instance creation' }
Board class >> withSpaces: anInteger withDice: aDie withPlayers: somePlayers withLaps: aLapNumber withEffect: anEffect [ 
	^ self new
		initializeWithSpaces: anInteger
		Dice: aDie
		Players: somePlayers
		Laps: aLapNumber
		Effects: anEffect.
		
]

{ #category : #action }
Board >> advance: aPlayer [
	| rolled effect |
	rolled := dice roll.
	effect := self selectEffect.
	(self isAboutToWin: aPlayer havingRolled: rolled)
		ifTrue: [ aPlayer move: spaces - aPlayer position ]
		ifFalse: [ aPlayer move: rolled ].
	effect applyTo: players.
	self skipToNextTurn
]

{ #category : #action }
Board >> assertIsTurnOf: aPlayer [
	(self isTurnOf: aPlayer)
		ifFalse: [ TurnError signal: 'This is not the player turn' ]
]

{ #category : #information }
Board >> boardLaps [
	^ laps
]

{ #category : #information }
Board >> boardSpaces [
	^ spaces
]

{ #category : #state }
Board >> hasFinished [
	^players anySatisfy: [ :aPlayer | aPlayer position >= spaces ]

	
]

{ #category : #initialization }
Board >> initializeWithSpaces: amountOfSpaces Dice: aDie Players: somePlayers Laps: aLapNumber Effects: someEffect [
	players := somePlayers asOrderedCollection.
	self verifyAndSetSpaces: amountOfSpaces.
	dice := aDie.
	laps := aLapNumber.
	self verifyAndSetEffectsProbability: someEffect.
	somePlayers do: [ :aPlayer | aPlayer addGame: self ]
]

{ #category : #action }
Board >> isAboutToWin: aPlayer havingRolled: result [
	^ aPlayer currentLap = laps and: (result + aPlayer position > spaces)
]

{ #category : #testing }
Board >> isTurnOf: aPlayer [
	^ (players first) = aPlayer
]

{ #category : #action }
Board >> play: aPlayer [
	self assertIsTurnOf: aPlayer.
	self advance: aPlayer
]

{ #category : #information }
Board >> scoreBoard [
	^ players
		sort: [ :aPlayer :otherPlayer | 
			(aPlayer position + (aPlayer currentLap * spaces))
				>= (otherPlayer position + (otherPlayer currentLap * spaces)) ]
]

{ #category : #selection }
Board >> selectEffect [
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

{ #category : #action }
Board >> skipToNextTurn [
  players addLast: (players removeFirst)
	
]

{ #category : #initialization }
Board >> verifyAndSetEffectsProbability: anEffect [
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
Board >> verifyAndSetSpaces: amountOfSpaces [
	amountOfSpaces < 0
		ifTrue: [ CreationError
				signal: 'You cannot create a board with a negative values' ]
		ifFalse: [ spaces := amountOfSpaces ]
]

{ #category : #state }
Board >> winner [
	^ players
		detect: [ :aPlayer | (aPlayer currentLap = laps) and: (aPlayer position = spaces) ]
]
