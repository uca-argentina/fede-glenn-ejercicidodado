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

{ #category : #definition }
Board class >> withSpaces: anInteger [
^self new initializeWithSpaces: anInteger
]

{ #category : #'instance creation' }
Board class >> withSpaces: anInteger withDice: aDie [ 
	^self new initializeWithSpaces: anInteger initialiazeWithDice: aDie
]

{ #category : #adding }
Board >> addPlayer: aPlayer [ 
	players add: aPlayer.
]

{ #category : #state }
Board >> hasFinished [
	^players detect: [ :aPlayer | aPlayer position >= spaces ]
		ifFound: [true]
	ifNone: [false]

	
]

{ #category : #objectCreation }
Board >> initializeWithSpaces: anInteger [
     players := OrderedCollection new.
     spaces:= anInteger.
]

{ #category : #initialization }
Board >> initializeWithSpaces: anInteger initialiazeWithDice: aDie [ 
	players := OrderedCollection new.
   spaces:= anInteger.
   dice:= aDie.
]

{ #category : #length }
Board >> length [
	^spaces
]

{ #category : #counting }
Board >> numOfPlayers [
	^players size
]

{ #category : #action }
Board >> play: aPlayer [ 
	^aPlayer rollAndAdvance: dice.
]
