Class {
	#name : #NoEffectCard,
	#superclass : #CardEffect,
	#instVars : [
		'target'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #application }
NoEffectCard class >> applyTo: aGame [ 
]

{ #category : #application }
NoEffectCard >> applyTo: aGame [ 
	^ self
]

{ #category : #targeting }
NoEffectCard >> target: aPlayer [ 
	target := aPlayer
]
