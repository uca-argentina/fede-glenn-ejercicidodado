Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'spaces',
		'players',
		'dice'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Board class >> withSpaces: anInteger withDice: aDie withPlayers: somePlayers [
	^ self new
		initializeWithSpaces: anInteger
		initialiazeWithDice: aDie
		initializeWithPlayers: somePlayers
]

{ #category : #action }
Board >> advance: aPlayer [
	| result |
	result := dice roll.
	result + aPlayer position > spaces
		ifTrue: [ aPlayer move: spaces - aPlayer position ]
		ifFalse: [ aPlayer move: result ].
	self skipTurn
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
Board >> initializeWithSpaces: anInteger initialiazeWithDice: aDie initializeWithPlayers: somePlayers [
   players:= somePlayers asOrderedCollection.
   spaces:= anInteger.
   dice:= aDie.
]

{ #category : #action }
Board >> play: aPlayer [
	(self canPlay: aPlayer)
		ifTrue: [self advance: aPlayer ]
		ifFalse: [ TurnError signal: 'This is not the player turn' ]
]

{ #category : #information }
Board >> scoreBoard [
	^players sort: [ :aPlayer :otherPlayer | aPlayer position >= otherPlayer position ].
]

{ #category : #action }
Board >> skipTurn [
  players addLast: (players removeFirst)
	
]

{ #category : #state }
Board >> winner [
	^players detect: [ :aPlayer | aPlayer position >= spaces].
]
