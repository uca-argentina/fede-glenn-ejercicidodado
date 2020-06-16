Class {
	#name : #OverloadCard,
	#superclass : #CardEffect,
	#instVars : [
		'target'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'effect application' }
OverloadCard >> applyTo: aGame [ 
	aGame applyOverloadCard: target.
]

{ #category : #classification }
OverloadCard >> isPermanent [
	^true
]

{ #category : #targeting }
OverloadCard >> target [
	^ target
]

{ #category : #targeting }
OverloadCard >> target: aPlayer [ 
	target := aPlayer
]
