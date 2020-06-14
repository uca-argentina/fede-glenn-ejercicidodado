Class {
	#name : #MoonWalkEffect,
	#superclass : #GameEffect,
	#instVars : [
		'stepsBack'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
MoonWalkEffect class >> withProbability: anInteger goBack: anInteger2 [
	^ self new initializeWithProbability: anInteger goBack: anInteger2
]

{ #category : #apply }
MoonWalkEffect >> applyTo: aGame [
	aGame applyMoonWalkEffect: self
]

{ #category : #accessing }
MoonWalkEffect >> backingSpaces [
	^stepsBack 
]

{ #category : #initialization }
MoonWalkEffect >> initializeWithProbability: anInteger goBack: anInteger2 [ 
	probability := anInteger.
	stepsBack := anInteger2.
]
