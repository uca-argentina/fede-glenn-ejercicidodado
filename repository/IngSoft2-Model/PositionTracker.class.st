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

{ #category : #classification }
PositionTracker >> getPlayersInOrderByLocker [
	| result |
	result := OrderedCollection new.
	(scoreBoard associations
		sort:
			[ :aAssociation :otherAssociation | otherAssociation value <= aAssociation value ])
		do: [ :association | result add: association key ].
	^ result
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

{ #category : #movement }
PositionTracker >> moveBackwards: aPlayer spaces: anInteger [ 
	| actualPosition newPosition |
	actualPosition := self inWhichPositionIs: aPlayer.
	newPosition := board get: (anInteger negated) from: actualPosition.
	scoreBoard add: aPlayer -> newPosition  
]
