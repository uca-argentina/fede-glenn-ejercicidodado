Class {
	#name : #PracticeBoard,
	#superclass : #Game,
	#category : #'IngSoft2-Model'
}

{ #category : #placement }
PracticeBoard >> set: aPlayer toPosition: aPosition toLap: aLap [
	aPlayer takeToPosition: (aPosition * aLap)
]
