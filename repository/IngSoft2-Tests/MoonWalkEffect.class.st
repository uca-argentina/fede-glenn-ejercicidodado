Class {
	#name : #MoonWalkEffect,
	#superclass : #Object,
	#category : #'IngSoft2-Tests'
}

{ #category : #apply }
MoonWalkEffect class >> applyTo: somePlayers [ 
	|moonWalkDistance |
	moonWalkDistance := ((somePlayers at: 1) position / 2) asInteger.
	somePlayers allButFirst do: [ :aPlayer | aPlayer moveBackwards: moonWalkDistance ]
]
