Class {
	#name : #AccelerationCard,
	#superclass : #CardEffect,
	#category : #'IngSoft2-Model'
}

{ #category : #'effect application' }
AccelerationCard >> applyTo: aGame [ 
	aGame applyAccelerationCard
]
