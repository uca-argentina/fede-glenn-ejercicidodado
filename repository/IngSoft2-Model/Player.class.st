Class {
	#name : #Player,
	#superclass : #Object,
	#instVars : [
		'name',
		'position',
		'actualBoard'
	],
	#classInstVars : [
		'position'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Player class >> called: aString [
 ^self new initializeWithName: aString. 
]

{ #category : #adding }
Player >> addGame: aBoard [
	actualBoard := aBoard
]

{ #category : #information }
Player >> currentLap [
	| result |
	result := (position / actualBoard boardSpaces) asInteger.
	position = actualBoard boardSpaces
		ifFalse: [ result := result + 1 ].
	^ result
]

{ #category : #initialization }
Player >> initializeWithName: aString [ 
	name := aString.
	position:=0.
]

{ #category : #movement }
Player >> move: anInteger [
	position := position + anInteger
]

{ #category : #movement }
Player >> moveBackwards: anInteger [ 
	position := position - anInteger
]

{ #category : #placement }
Player >> moveToZero [
	position := position - self position.
]

{ #category : #information }
Player >> position [
	position = (actualBoard boardSpaces * actualBoard boardLaps)
		ifTrue: [ ^ actualBoard boardSpaces  ]
		ifFalse: [ ^ position % actualBoard boardSpaces ]
]

{ #category : #information }
Player >> rank [
	^actualBoard scoreBoard indexOf: self.
]

{ #category : #action }
Player >> roll: aDie [ 
	^aDie roll 
]

{ #category : #placement }
Player >> takeToPosition: aPosition [ 
	position := aPosition.
]
