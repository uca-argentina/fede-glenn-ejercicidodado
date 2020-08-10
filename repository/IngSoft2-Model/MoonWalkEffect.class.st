Class {
	#name : #MoonWalkEffect,
	#superclass : #GameEffect,
	#instVars : [
		'stepsBack'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #instantiation }
MoonWalkEffect class >> goBack: anInteger [
	^ self new goBack: anInteger
]

{ #category : #apply }
MoonWalkEffect >> applyTo: aGame [
	aGame applyMoonWalkEffect: self
]

{ #category : #accessing }
MoonWalkEffect >> backingSpaces [
	^stepsBack 
]

{ #category : #initializarion }
MoonWalkEffect >> goBack: anInteger [
	stepsBack := anInteger
]
