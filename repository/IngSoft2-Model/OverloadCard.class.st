Class {
	#name : #OverloadCard,
	#superclass : #CardEffect,
	#instVars : [
		'target'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'card application' }
OverloadCard >> applyTo: aGame [ 
	aGame applyOverloadCard.
]

{ #category : #classification }
OverloadCard >> isPermanent [
	^true
]

{ #category : #targeting }
OverloadCard >> target [
	^ target
]

{ #category : #'as yet unclassified' }
OverloadCard >> target: aPlayer [ 
	target := aPlayer
]
