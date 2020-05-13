Class {
	#name : #LoadedDie,
	#superclass : #Object,
	#instVars : [
		'value'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
LoadedDie class >> withValue: anInteger [
	anInteger > 0
		ifTrue: [ ^ LoadedDie new initializeWithValue: anInteger ]
		ifFalse: [ CreationError
				signal: 'You cannot create a die with a negative values' ].
]

{ #category : #initialization }
LoadedDie >> initializeWithValue: anInteger [ 
	value:= anInteger .
]

{ #category : #action }
LoadedDie >> roll [
	^value.
]
