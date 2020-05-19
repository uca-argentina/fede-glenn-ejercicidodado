Class {
	#name : #AtomicBombEffect,
	#superclass : #GameEffect,
	#category : #'IngSoft2-Model'
}

{ #category : #apply }
AtomicBombEffect >> applyTo: somePlayers [
	somePlayers
		do: [ :aPlayer | aPlayer moveToZero ]
]
