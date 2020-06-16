Class {
	#name : #AccelerationCard,
	#superclass : #CardEffect,
	#instVars : [
		'target'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'effect application' }
AccelerationCard >> applyTo: aGame [ 
	aGame applyAccelerationCard
]

{ #category : #classification }
AccelerationCard >> isPermanent [
	^true
]

{ #category : #targeting }
AccelerationCard >> target: aPlayer [ 
	target:= aPlayer 
]
