Class {
	#name : #WormHoleEffect,
	#superclass : #GameEffect,
	#category : #'IngSoft2-Model'
}

{ #category : #apply }
WormHoleEffect >> applyTo: somePlayers [
	| currentPlayer |
	currentPlayer := somePlayers first.
	currentPlayer position >= 4
		ifTrue:[ currentPlayer  moveBackwards: 4]
		ifFalse:[currentPlayer moveToZero].
]
