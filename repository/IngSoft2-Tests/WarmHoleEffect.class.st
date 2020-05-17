Class {
	#name : #WarmHoleEffect,
	#superclass : #Object,
	#category : #'IngSoft2-Tests'
}

{ #category : #apply }
WarmHoleEffect class >> applyTo: somePlayer [ 
	(somePlayer at: 1) moveBackwards: 4.
]
