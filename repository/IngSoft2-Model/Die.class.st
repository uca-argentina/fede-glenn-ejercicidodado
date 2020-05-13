Class {
	#name : #Die,
	#superclass : #Object,
	#instVars : [
		'sides'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Die class >> withSides: anInteger [
	anInteger > 0
		ifTrue: [ ^ self new initializeWithSides: anInteger ]
		ifFalse: [ CreationError
				signal: 'You cannot create a die with a negative values' ].
]

{ #category : #initialization }
Die >> initializeWithSides: anInteger [ 
	sides:=anInteger.
]

{ #category : #action }
Die >> roll [
	^(Random new nextInt:sides).
]
