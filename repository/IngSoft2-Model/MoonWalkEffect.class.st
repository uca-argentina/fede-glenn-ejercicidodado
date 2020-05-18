Class {
	#name : #MoonWalkEffect,
	#superclass : #GameEffect,
	#instVars : [
		'probability'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #apply }
MoonWalkEffect >> applyTo: somePlayers [ 
	|moonWalkDistance |
	moonWalkDistance := ((somePlayers at: 1) position / 2) asInteger.
	somePlayers allButFirst do: [ :aPlayer | aPlayer moveBackwards: moonWalkDistance ]
]
