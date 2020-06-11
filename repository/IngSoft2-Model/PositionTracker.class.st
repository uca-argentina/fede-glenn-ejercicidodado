Class {
	#name : #PositionTracker,
	#superclass : #Object,
	#instVars : [
		'scoreBoard',
		'board'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
PositionTracker class >> withBoard: aBoard Players: somePlayers [ 
	^self new initializeWithBoard: aBoard players: somePlayers.
]

{ #category : #accessing }
PositionTracker >> inWhichPositionIs: aPlayer [ 
	^scoreBoard at: aPlayer.
]

{ #category : #initiali }
PositionTracker >> initializeWithBoard: aBoard players: somePlayers [
	| startingPosition |
	board := aBoard.
	scoreBoard := Dictionary new.
	startingPosition := aBoard startingLocker.
	somePlayers
		do: [ :aPlayer | scoreBoard add: aPlayer -> startingPosition ]
]

{ #category : #state }
PositionTracker >> isThereAWinner [
	^scoreBoard values anySatisfy: [:aLocker | aLocker = board lastLocker].
		
	
]

{ #category : #movement }
PositionTracker >> move: aPlayer havingRolled: anInteger [
	| actualPosition newPosition |
	actualPosition := self inWhichPositionIs: aPlayer.
	newPosition := board get: anInteger from: actualPosition.
	scoreBoard add: aPlayer -> newPosition
]
