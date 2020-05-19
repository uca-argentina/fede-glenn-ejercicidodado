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
		ifTrue: [ ^ result ]
		ifFalse: [ ^result + 1 ]
]

{ #category : #'instance creation' }
Player >> initializeWithName: aString [ 
	name := aString.
	position:=0.
]

{ #category : #action }
Player >> move: anInteger [
	position := position + anInteger
]

{ #category : #movement }
Player >> moveBackwards: anInteger [ 
	position := position - anInteger
]

{ #category : #movement }
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
