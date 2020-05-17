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
		initialiazeWithDice: aDie
		initializeWithPlayers: somePlayers
		initializeWithLaps: aLapNumber
		initializeWithEffects: NoEffect.
]

{ #category : #'instance creation' }
Board class >> withSpaces: anInteger withDice: aDie withPlayers: somePlayers withLaps: aLapNumber withEffect: anEffect [ 
	^ self new
		initializeWithSpaces: anInteger
		initialiazeWithDice: aDie
		initializeWithPlayers: somePlayers
		initializeWithLaps: aLapNumber
		initializeWithEffects: anEffect.
		
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
	self skipTurn
]

{ #category : #'as yet unclassified' }
Board >> boardLaps [
	^ laps
]

{ #category : #'as yet unclassified' }
Board >> boardSpaces [
	^ spaces
]

{ #category : #testing }
Board >> canPlay: aPlayer [
	^ (players at: 1) = aPlayer
]

{ #category : #state }
Board >> hasFinished [
	^players anySatisfy: [ :aPlayer | aPlayer position >= spaces ]

	
]

{ #category : #initialization }
Board >> initializeWithSpaces: anInteger initialiazeWithDice: aDie initializeWithPlayers: somePlayers initializeWithLaps: aLapNumber initializeWithEffects: anEffect [
	players := somePlayers asOrderedCollection.
	spaces := anInteger.
	dice := aDie.
	laps := aLapNumber.
	effects := anEffect.
	somePlayers do: [ :aPlayer | aPlayer addGame: self ]
]

{ #category : #action }
Board >> isAboutToWin: aPlayer havingRolled: result [
	^ aPlayer currentLap = laps & (result + aPlayer position > spaces)
]

{ #category : #action }
Board >> play: aPlayer [
	(self canPlay: aPlayer)
		ifTrue: [self advance: aPlayer ]
		ifFalse: [ TurnError signal: 'This is not the player turn' ]
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
	^effects
]

{ #category : #action }
Board >> skipTurn [
  players addLast: (players removeFirst)
	
]

{ #category : #state }
Board >> winner [
	^ players
		detect: [ :aPlayer | (aPlayer currentLap = laps) & (aPlayer position = spaces) ]
]
