Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'board'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #'instance creation' }
Board class >> withSpaces: amountOfSpaces Laps: amountOfLaps [ 
	^self new initializeWithSpaces: amountOfSpaces laps: amountOfLaps. 	
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
Board >> initializeWithSpaces: amountOfSpaces laps: amountOfLaps [ 
	(amountOfSpaces < 0 or: amountOfLaps < 0)
		ifTrue: [ CreationError
				signal: 'You cannot create a board with a negative values' ]
		ifFalse: [ 
			board := OrderedCollection new.
			1 to: amountOfLaps do:  [ :lap | 
				1 to:  amountOfSpaces do: [:lockerNumber | 
					board add: (Locker position: lockerNumber lap: lap).
					].]. ]
]

{ #category : #'tree accessing' }
Board >> lastLocker [
	^board last 
]

{ #category : #accesing }
Board >> startingLocker [
	^ board first.
]
