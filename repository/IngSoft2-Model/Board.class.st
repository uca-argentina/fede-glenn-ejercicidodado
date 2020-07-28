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
	self padEffects: arrayOfEffects.
	board := OrderedCollection new.
	arrayOfShuffledEffects := ProbabilityDistributor new
		createArrayWith: arrayOfEffects
		size: amountOfLaps * amountOfSpaces.
	count := 1.
	1 to: amountOfLaps do: [ :lap | 
		1 to: amountOfSpaces do: [ :lockerNumber | 
			board
				add:
					(Locker
						position: lockerNumber
						lap: lap
						effect: (arrayOfShuffledEffects at: count)).
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

{ #category : #accessing }
Board >> getBack: positionsToMove from: actualLocker [
	| newPosition |
	(board indexOf: actualLocker) <= positionsToMove
		ifTrue: [ newPosition := self startingLocker  ]
		ifFalse: [ newPosition := board
				at: (board indexOf: actualLocker) - positionsToMove ].
	^ newPosition
]

{ #category : #position }
Board >> howFarFromStart: aLocker [ 
	^(aLocker position - 1) 
]

{ #category : #initialization }
Board >> initializeWithSpaces: amountOfSpaces laps: amountOfLaps effect: arrayOfEffects [
	((self validateSpaces: amountOfSpaces andLaps: amountOfLaps)
		or: (self validateEffectProbabilities: arrayOfEffects))
		ifTrue: [ CreationError
				signal: 'You cannot create a board with invalid values' ]
		ifFalse: [ self
				generateBoardWithSpaces: amountOfSpaces
				laps: amountOfLaps
				effect: arrayOfEffects asOrderedCollection  ]
]

{ #category : #accessing }
Board >> lastLocker [
	^board last 
]

{ #category : #initialization }
Board >> padEffects: arrayOfEffects [
	arrayOfEffects
		add:
			(NoEffect
				withProbability: 1 - (arrayOfEffects sum: [ :anEffect | anEffect probability ]))
]

{ #category : #accessing }
Board >> startingLocker [
	^ board first.
]

{ #category : #verification }
Board >> validateEffectProbabilities: aCollection [ 
	 ^(aCollection sum: [ :anObject | anObject probability ]) > 1
]

{ #category : #initialization }
Board >> validateSpaces: amountOfSpaces andLaps: amountOfLaps [
	^ amountOfSpaces < 0 or: amountOfLaps < 0
]
