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
	^self new initializeWithSides: anInteger.
]

{ #category : #initialization }
Die >> initializeWithSides: anInteger [ 
	sides:=anInteger.
]

{ #category : #rolling }
Die >> roll [
	^(Random new nextInt:sides).
]
