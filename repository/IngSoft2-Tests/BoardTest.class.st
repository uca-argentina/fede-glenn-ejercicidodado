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
		effects: (Array with: (NoEffect withProbability: 1)).
	starting := board startingLocker.
	6
		timesRepeat:
			(self
				assert: (starting := board get: 1 from: starting) effect
				equals: NoEffect new)
]

{ #category : #tests }
BoardTest >> testCreateBoardWithSeveralEffects [
	| board result starting actualEffect counter|
	board := Board
		withSpaces: 2
		Laps: 1
		effects:
			(Array
				with: (NoEffect withProbability: 0.5)
				with: (WormHoleEffect withProbability: 0.5)).
	starting := board startingLocker.
	result := OrderedCollection new.
	counter := 0.
	2
		timesRepeat:
			[ 
			actualEffect := (board get: counter from: starting) effect.
			result add: actualEffect.
			counter := counter +1].
	self assert: (result anySatisfy:[:anEffect | anEffect = NoEffect new]).
	self assert: (result anySatisfy:[:anEffect | anEffect = WormHoleEffect new]).




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
