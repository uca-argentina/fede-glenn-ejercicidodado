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

{ #category : #rolling }
Player class >> called: aString [
 ^self new initializeWithName: aString. 
]

{ #category : #'instance creation' }
Player >> initializeWithName: aString [ 
	name := aString.
	position:=0.
]

{ #category : #position }
Player >> position [
	^position.
]

{ #category : #action }
Player >> roll: aDie [ 
	^aDie roll 
]

{ #category : #action }
Player >> rollAndReturnPosition: aDie [
	position:= position + (self roll: aDie).
	^position
]
