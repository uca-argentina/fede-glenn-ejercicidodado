Class {
	#name : #AtomicBombEffect,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #effect }
AtomicBombEffect class >> applyTo: somePlayers [
	somePlayers
		do: [ :aPlayer | aPlayer moveBackwards: aPlayer position ]
]
