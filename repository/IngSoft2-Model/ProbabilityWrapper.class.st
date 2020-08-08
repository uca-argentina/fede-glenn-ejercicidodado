Class {
	#name : #ProbabilityWrapper,
	#superclass : #Object,
	#instVars : [
		'object',
		'probability'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #instantiation }
ProbabilityWrapper class >> with: anObject probability: aProbability [
	^ self new initializeWith: anObject probability: aProbability
]

{ #category : #access }
ProbabilityWrapper >> element [
	^ object
]

{ #category : #initialization }
ProbabilityWrapper >> initializeWith: anObject probability: aProbability [ 
	object := anObject.
	probability := aProbability.
]

{ #category : #access }
ProbabilityWrapper >> probability [
	^ probability
]
