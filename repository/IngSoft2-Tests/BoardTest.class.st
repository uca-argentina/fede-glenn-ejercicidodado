Class {
	#name : #BoardTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
BoardTest >> testBoardWithProbabilityMoreThanOneHundredFails [
	self
		should: [ Board
				withSpaces: 10
				Laps: 1
				effects:
					{(NoEffect withProbability: 0.6).
					(WormHoleEffect withProbability: 0.5)} ]
		raise: CreationError
]

{ #category : #tests }
BoardTest >> testCreateBoardWithNoEffects [
	| board starting |
	board := Board
		withSpaces: 3
		Laps: 2
		effects: {(NoEffect withProbability: 1)}.
	starting := board startingLocker.
	6
		timesRepeat:
			(self
				assert: (starting := board get: 1 from: starting) effect
				equals: NoEffect new)
]

{ #category : #tests }
BoardTest >> testCreateBoardWithNoEffectsByDefault [
	| board result starting actualEffect counter |
	board := Board
		withSpaces: 10
		Laps: 10
		effects: {(WormHoleEffect withProbability: 0.15)}.
	starting := board startingLocker.
	result := OrderedCollection new.
	counter := 0.
	100
		timesRepeat: [ actualEffect := (board get: counter from: starting) effect.
			result add: actualEffect.
			counter := counter + 1 ].
	self
		assert: (result anySatisfy: [ :anEffect | anEffect = NoEffect new ]).
	self
		assert: (result anySatisfy: [ :anEffect | anEffect = WormHoleEffect new ])
]

{ #category : #tests }
BoardTest >> testCreateBoardWithSeveralEffects [
	| board result starting actualEffect counter |
	board := Board
		withSpaces: 2
		Laps: 1
		effects:
			{(NoEffect withProbability: 0.5).
			(WormHoleEffect withProbability: 0.5)}.
	starting := board startingLocker.
	result := OrderedCollection new.
	counter := 0.
	2
		timesRepeat: [ actualEffect := (board get: counter from: starting) effect.
			result add: actualEffect.
			counter := counter + 1 ].
	self
		assert: (result anySatisfy: [ :anEffect | anEffect = NoEffect new ]).
	self
		assert: (result anySatisfy: [ :anEffect | anEffect = WormHoleEffect new ])
]

{ #category : #tests }
BoardTest >> testDistribiutionOfEffects [
	| board result starting actualEffect counter |
	board := Board
		withSpaces: 10
		Laps: 10
		effects:
			{(WormHoleEffect withProbability: 0.15).
			(AtomicBombEffect withProbability: 0.02)}.
	starting := board startingLocker.
	result := OrderedCollection new.
	counter := 0.
	100
		timesRepeat: [ actualEffect := (board get: counter from: starting) effect.
			result add: actualEffect.
			counter := counter + 1 ].
	self
		assert: (result count: [ :anEffect | anEffect = NoEffect new ])
		identicalTo: 83.
	self
		assert: (result count: [ :anEffect | anEffect = WormHoleEffect new ])
		identicalTo: 15.
	self
		assert: (result count: [ :anEffect | anEffect = AtomicBombEffect new ])
		identicalTo: 2
]

{ #category : #tests }
BoardTest >> testGetFollowingLocker [
	|board starting last|
	board := Board withSpaces:2 Laps: 1.
	starting := board startingLocker.
	last := board lastLocker.
	self assert: (board get: 1 from: starting) equals: last.
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
