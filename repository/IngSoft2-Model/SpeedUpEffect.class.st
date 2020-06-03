Class {
	#name : #SpeedUpEffect,
	#superclass : #GameEffect,
	#category : #'IngSoft2-Model'
}

{ #category : #apply }
SpeedUpEffect >> applyTo: somePlayers [
	(somePlayers first) move: 4.
]
