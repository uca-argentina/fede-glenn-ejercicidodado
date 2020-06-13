Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'board'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Board class >> withSpaces: amountOfSpaces Laps: amountOfLaps [
	^ self new
		initializeWithSpaces: amountOfSpaces
		laps: amountOfLaps
		effect: (Array with: (NoEffect withProbability: 1))
]

{ #category : #'instance creation - old' }
Board class >> withSpaces: anInteger Laps: numberOfLaps effects: arrayOfEffects [
	^ self new
		initializeWithSpaces: anInteger
		laps: numberOfLaps
		effect: arrayOfEffects
]

{ #category : #initialization }
Board >> generateBoardWithSpaces: amountOfSpaces laps: amountOfLaps effect: arrayOfEffects [
	| arrayOfShuffledEffects count |
	board := OrderedCollection new.
	arrayOfShuffledEffects := ProbabilityDistributor createArrayWith: arrayOfEffects size: amountOfLaps * amountOfSpaces.
	count := 1.
	1 to: amountOfLaps do: [ :lap | 
		1 to: amountOfSpaces do: [ :lockerNumber | 
			board
				add:
					(Locker position: lockerNumber lap: lap effect: (arrayOfShuffledEffects at: count)).
			count := count + 1 ] ] 
]

{ #category : #accessing }
Board >> get: positionsToMove from: actualLocker [
	| newPosition |
	(board indexOf: actualLocker) + positionsToMove > board size
		ifTrue: [ newPosition := self lastLocker ]
		ifFalse: [ newPosition := board
				at: (board indexOf: actualLocker) + positionsToMove ].
	^ newPosition
]

{ #category : #initialization }
Board >> initializeWithSpaces: amountOfSpaces laps: amountOfLaps effect: arrayOfEffects [
	(amountOfSpaces < 0 or: amountOfLaps < 0)
		ifTrue: [ CreationError
				signal: 'You cannot create a board with a negative values' ]
		ifFalse: [ self
				generateBoardWithSpaces: amountOfSpaces
				laps: amountOfLaps
				effect:  arrayOfEffects] 
]

{ #category : #'tree accessing' }
Board >> lastLocker [
	^board last 
]

{ #category : #accesing }
Board >> startingLocker [
	^ board first.
]
