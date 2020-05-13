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

{ #category : #initialization }
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

{ #category : #action }
Board >> play: aPlayer [ 
	^aPlayer rollAndReturnPosition: dice.
]
