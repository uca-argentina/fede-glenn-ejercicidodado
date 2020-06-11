Class {
	#name : #BoardTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

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
