Class {
	#name : #WormHoleEffect,
	#superclass : #GameEffect,
	#category : #'IngSoft2-Model'
}

{ #category : #operations }
WormHoleEffect >> applyTo: somePlayers [
	(somePlayers at: 1) moveBackwards: 4.
]
