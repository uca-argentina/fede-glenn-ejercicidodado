Class {
	#name : #WormHoleEffect,
	#superclass : #GameEffect,
	#category : #'IngSoft2-Model'
}

{ #category : #apply }
WormHoleEffect >> applyTo: somePlayers [
	| actualTurn |
	actualTurn := somePlayers at: 1.
	actualTurn position >= 4
		ifTrue:[ actualTurn  moveBackwards: 4]
		ifFalse:[actualTurn moveToZero].
]
