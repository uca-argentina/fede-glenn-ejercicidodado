Class {
	#name : #DrawCardEffect,
	#superclass : #GameEffect,
	#category : #'IngSoft2-Model'
}

{ #category : #'effect application' }
DrawCardEffect >> applyTo: aGame [ 
	aGame applyDrawCardEffect
]
