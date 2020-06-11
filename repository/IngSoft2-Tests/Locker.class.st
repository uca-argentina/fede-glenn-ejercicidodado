Class {
	#name : #Locker,
	#superclass : #Object,
	#instVars : [
		'position',
		'lap'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #'instance creation' }
Locker class >> position: lockerNumber  lap: lapNumber [ 
	^ self new initializeWithPosition: lockerNumber lap: lapNumber.
]

{ #category : #comparing }
Locker >> = otherLocker [
	^ (position == otherLocker position) and: (lap == otherLocker lap)
]

{ #category : #comparing }
Locker >> == otherLocker [
	^ (position == otherLocker position) and: (lap == otherLocker lap)
]

{ #category : #comparing }
Locker >> hash [
	^ self species hash bitXor: (self position hash bitXor: self lap hash)
]

{ #category : #initialization }
Locker >> initializeWithPosition: positionNumber lap: lapNumber [ 
	position := positionNumber.
	lap := lapNumber.
]

{ #category : #private }
Locker >> lap [
	^lap
]

{ #category : #private }
Locker >> position [
	^position
]
