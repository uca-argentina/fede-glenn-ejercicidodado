Class {
	#name : #AtomicBombEffect,
	#superclass : #GameEffect,
	#instVars : [
		'probability'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #effect }
AtomicBombEffect >> applyTo: somePlayers [
	somePlayers
		do: [ :aPlayer | aPlayer moveBackwards: aPlayer position ]
]
