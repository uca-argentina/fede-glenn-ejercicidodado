Class {
	#name : #ProbabilityDistributor,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #creation }
ProbabilityDistributor >> createArrayWith: aCollection size: length [ 
	^self createShuffledCollection: aCollection size: length.
]

{ #category : #instantiation }
ProbabilityDistributor >> createShuffledCollection: aCollection defaultElement: defaultElement size: anInteger [
	| paddedCollection totalProbability |
	paddedCollection := aCollection asOrderedCollection.
	totalProbability := aCollection
		sum: [ :aProbableObject | aProbableObject probability ].
	totalProbability <= 1
		ifTrue: [ paddedCollection
				add:
					(ProbabilityWrapper
						with: defaultElement
						probability: (1 - totalProbability round: 3)) ]
		ifFalse: [ CreationError signal: 'Probability over 1' ].
	^ self createShuffledCollection: paddedCollection size: anInteger
]

{ #category : #creation }
ProbabilityDistributor >> createShuffledCollection: probableObjects size: length [
	"Recieves a collection of probable objects with element and probability"

	| result |
	result := OrderedCollection new.
	probableObjects
		do: [ :aProbableObject | 
			result
				add: aProbableObject element
				withOccurrences: (aProbableObject probability * length) truncated ].
	result size = length
		ifFalse: [ result add: probableObjects last element ].
	^ result shuffle
]
