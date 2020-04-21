Class {
	#name : #LoadedDie,
	#superclass : #Object,
	#instVars : [
		'value'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
LoadedDie class >> withSides: anInteger [ 
	self shouldBeImplemented.
]

{ #category : #'instance creation - old' }
LoadedDie class >> withValue: anInteger [ 
  ^LoadedDie new initializeWithValue: anInteger.
]

{ #category : #initialization }
LoadedDie >> initializeWithValue: anInteger [ 
	value:= anInteger .
]

{ #category : #rolling }
LoadedDie >> roll [
	^value.
]
