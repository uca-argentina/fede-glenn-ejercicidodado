Class {
	#name : #CancellationCard,
	#superclass : #CardEffect,
	#instVars : [
		'target'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'effect application' }
CancellationCard >> applyTo: aGame [ 
	aGame applyCancellationCard: target.
]

{ #category : #'as yet unclassified' }
CancellationCard >> isPermanent [
	^false
]

{ #category : #targeting }
CancellationCard >> target: aCard [ 
	target := aCard
]
