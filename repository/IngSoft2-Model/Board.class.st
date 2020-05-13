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
Board class >> withSpaces: anInteger withDice: aDie [ 
	^self new initializeWithSpaces: anInteger initialiazeWithDice: aDie
]

{ #category : #adding }
Board >> addPlayer: aPlayer [ 
	players add: aPlayer.
]

{ #category : #action }
Board >> advance: aPlayer [
	self skipTurn.
	^ aPlayer rollAndAdvance: dice
]

{ #category : #action }
Board >> canPlay: aPlayer [
	^ (players at: 1) = aPlayer
]

{ #category : #state }
Board >> hasFinished [
	^players anySatisfy: [ :aPlayer | aPlayer position >= spaces ]

	
]

{ #category : #initialization }
Board >> initializeWithSpaces: anInteger initialiazeWithDice: aDie [ 
	players := OrderedCollection new.
   spaces:= anInteger.
   dice:= aDie.
]

{ #category : #action }
Board >> play: aPlayer [
	(self canPlay: aPlayer)
		ifTrue: [ ^ self advance: aPlayer ]
		ifFalse: [ TurnError signal: 'This is not the player turn' ]
]

{ #category : #position }
Board >> scoreBoard [
	^players sort: [ :aPlayer :otherPlayer | aPlayer position >= otherPlayer position ].
]

{ #category : #action }
Board >> skipTurn [
  players addLast: (players removeFirst)
	
]

{ #category : #winner }
Board >> winner [
	^players detect: [ :aPlayer | aPlayer position >= spaces].
]
