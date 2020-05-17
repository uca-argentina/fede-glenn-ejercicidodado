Class {
	#name : #SpeedUpEffect,
	#superclass : #Object,
	#category : #'IngSoft2-Tests'
}

{ #category : #'as yet unclassifiedapply' }
SpeedUpEffect class >> applyTo: somePlayer [ 
	(somePlayer at: 1) move: 4.
]
