Class {
	#name : #PracticeBoard,
	#superclass : #Board,
	#category : #'IngSoft2-Model'
}

{ #category : #movement }
PracticeBoard >> set: aPlayer toPosition: anInteger [ 
	self shouldBeImplemented.
]

{ #category : #placement }
PracticeBoard >> set: aPlayer toPosition: aPosition toLap: aLap [
	aPlayer takeToPosition: (aPosition * aLap)
]
