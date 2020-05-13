Class {
	#name : #Player,
	#superclass : #Object,
	#instVars : [
		'name',
		'position'
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

{ #category : #'instance creation' }
Player >> initializeWithName: aString [ 
	name := aString.
	position:=0.
]

{ #category : #action }
Player >> move: anInteger [
	position := position + anInteger
]

{ #category : #information }
Player >> position [
	^position.
]

{ #category : #action }
Player >> roll: aDie [ 
	^aDie roll 
]
