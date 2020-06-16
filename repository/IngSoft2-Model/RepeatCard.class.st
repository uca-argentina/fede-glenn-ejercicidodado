Class {
	#name : #RepeatCard,
	#superclass : #CardEffect,
	#instVars : [
		'target'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'card application' }
RepeatCard >> applyTo: aGame [ 
	aGame applyRepeatCar: target.
]

{ #category : #classification }
RepeatCard >> isPermanent [
	^false
]

{ #category : #targeting }
RepeatCard >> target: aPlayer [ 
	target := aPlayer
]
