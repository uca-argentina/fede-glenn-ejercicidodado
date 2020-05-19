Class {
	#name : #SpeedUpEffect,
	#superclass : #GameEffect,
	#category : #'IngSoft2-Model'
}

{ #category : #apply }
SpeedUpEffect >> applyTo: somePlayers [
	(somePlayers at: 1) move: 4.
]
