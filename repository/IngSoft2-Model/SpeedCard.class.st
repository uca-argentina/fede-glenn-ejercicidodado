Class {
	#name : #SpeedCard,
	#superclass : #CardEffect,
	#instVars : [
		'target'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'card application' }
SpeedCard >> applyTo: aGame [ 
	aGame applySpeedCard.
]

{ #category : #classification }
SpeedCard >> isPermanent [
	^true
]

{ #category : #targeting }
SpeedCard >> target [
	^ target
]

{ #category : #targeting }
SpeedCard >> target: aPlayer [
	target := aPlayer
]
