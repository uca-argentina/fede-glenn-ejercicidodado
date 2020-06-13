Class {
	#name : #ProbabilityDistributor,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #creation }
ProbabilityDistributor class >> createArrayWith: aCollection size: length [ 
	^self new createShuffledCollection: aCollection size: length.
]

{ #category : #creation }
ProbabilityDistributor >> createShuffledCollection: aCollection size: length [
	| result |
	result := OrderedCollection new.
	aCollection
		do: [ :anObject | 
			result
				add: anObject
				withOccurrences: (anObject probability * length) truncated ].
	^result shuffle.
]
