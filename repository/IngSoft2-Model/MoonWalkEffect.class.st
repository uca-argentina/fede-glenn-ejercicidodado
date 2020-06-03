Class {
	#name : #MoonWalkEffect,
	#superclass : #GameEffect,
	#category : #'IngSoft2-Model'
}

{ #category : #apply }
MoonWalkEffect >> applyTo: somePlayers [ 
	|moonWalkDistance |
	moonWalkDistance := ((somePlayers first) position / 2) asInteger.
	somePlayers allButFirst do: [ :aPlayer | aPlayer moveBackwards: moonWalkDistance ]
]
