Class {
	#name : #BoardTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
BoardTest >> testCreateBoardWithNoEffects [
	| board starting |
	board := Board
		withSpaces: 3
		Laps: 2
		effects: (NoEffect withProbability: 1).
	starting := board startingLocker.
	6 timesRepeat:
			(self assert:
					(starting := board get: 1 from: starting) effect
						equals: NoEffect new)
]

{ #category : #tests }
BoardTest >> testCreateBoardWithSeveralEffects [
	| board result starting |
	board := Board
		withSpaces: 2
		Laps: 1
		effects:
			(Array
				with: (NoEffect withProbability: 0.5)
				with: (WormHoleEffect withProbability: 0.5)).
	starting := board startingLocker.
	result := OrderedCollection new.
	2
		timesRepeat: [ result add: (board get: 1 from: starting) effect.
			starting := board get: 1 from: starting ].
	self assert: result removeDuplicates size equals: 2
]

{ #category : #tests }
BoardTest >> testNotAllowToCreateBoardWithNegativeLaps [
	self
		should: [ Board withSpaces:4 Laps: -2. ]
		raise: CreationError
]

{ #category : #tests }
BoardTest >> testNotAllowToCreateBoardWithNegativeSpaces [
	self
		should: [ Board withSpaces:-4 Laps: 2. ]
		raise: CreationError
]
