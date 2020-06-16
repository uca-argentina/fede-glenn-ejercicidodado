Class {
	#name : #NoEffectCard,
	#superclass : #CardEffect,
	#instVars : [
		'target'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'effect application' }
NoEffectCard >> applyTo: aGame [ 
	^ self
]

{ #category : #classification }
NoEffectCard >> isPermanent [
	^false
]
