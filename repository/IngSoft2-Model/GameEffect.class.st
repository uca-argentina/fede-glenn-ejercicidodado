Class {
	#name : #GameEffect,
	#superclass : #Object,
	#instVars : [
		'probability'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #probability }
GameEffect class >> withProbability: aFloat [
	^ self new initializeWithProbability: aFloat
]

{ #category : #initialization }
GameEffect >> initializeWithProbability: aFloat [
	probability := aFloat
]

{ #category : #probability }
GameEffect >> probability [
	^ probability
]
