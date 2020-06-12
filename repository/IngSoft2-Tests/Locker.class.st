Class {
	#name : #Locker,
	#superclass : #Object,
	#instVars : [
		'position',
		'effect',
		'lap'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #'instance creation' }
Locker class >> position: lockerNumber  lap: lapNumber [ 
	^ self new initializeWithPosition: lockerNumber lap: lapNumber effect: (NoEffect withProbability: 1).
]

{ #category : #'instance creation' }
Locker class >> position: anInteger lap: anInteger2 effect: anEffect [ 
	^ self new initializeWithPosition: anInteger lap: anInteger2 effect: anEffect.
]

{ #category : #comparing }
Locker >> <= otherLocker [
	lap > otherLocker lap
		ifTrue: [ ^ false ]
		ifFalse: [ lap < otherLocker lap
				ifTrue: [ ^ true ]
				ifFalse: [ ^ position <= otherLocker position ] ]
			
]

{ #category : #comparing }
Locker >> = otherLocker [
	^ position == otherLocker position and: (effect = otherLocker effect)
]

{ #category : #comparing }
Locker >> == otherLocker [
	^ position == otherLocker position and: lap == otherLocker lap
]

{ #category : #accessing }
Locker >> effect [
	^ effect
]

{ #category : #comparing }
Locker >> hash [
	^ self species hash bitXor: (self position hash bitXor: self lap hash)
]

{ #category : #initialization }
Locker >> initializeWithPosition: positionNumber lap: lapNumber effect: anEffect [
	position := positionNumber.
	lap := lapNumber.
	effect := anEffect 
]

{ #category : #private }
Locker >> lap [
	^lap
]

{ #category : #private }
Locker >> position [
	^position
]
