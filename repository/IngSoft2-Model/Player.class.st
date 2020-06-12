Class {
	#name : #Player,
	#superclass : #Object,
	#instVars : [
		'name'
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

{ #category : #initialization }
Player >> initializeWithName: aString [ 
	name := aString.
]

{ #category : #rolling }
Player >> roll: aDie [ 
	^aDie roll
]
