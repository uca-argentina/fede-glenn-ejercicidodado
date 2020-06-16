Class {
	#name : #TurnManager,
	#superclass : #Object,
	#instVars : [
		'players'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
TurnManager class >> organize: somePlayers [ 
	^self new initializeWithPlayers: somePlayers
]

{ #category : #accessing }
TurnManager >> allPlayersButActual [
	^ players select: [ :aPlayer | aPlayer ~= players first ]
]

{ #category : #turn }
TurnManager >> alreadyPlayed: aPlayer [ 
	players addLast: (players removeFirst)
]

{ #category : #accessing }
TurnManager >> currentTurnPlayer [
	^players first
]

{ #category : #turn }
TurnManager >> endSpecialTurn: aPlayer [ 
	players removeFirst.
]

{ #category : #initialization }
TurnManager >> initializeWithPlayers: somePlayers [ 
	players := somePlayers asOrderedCollection.
]

{ #category : #turn }
TurnManager >> isTurnOf: aPlayer [
	aPlayer = players first
		ifFalse: [ TurnError signal: 'This is not the player turn'  ]
]

{ #category : #turn }
TurnManager >> specialTurn: aPlayer [
	players addFirst: aPlayer.
]
