Class {
	#name : #Dice,
	#superclass : #Object,
	#instVars : [
		'dice'
	],
	#classInstVars : [
		'dice'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #creation }
Dice class >> initializeNewGroup [
	self shouldBeImplemented.
]

{ #category : #instanceCreation }
Dice class >> newGroup [
	^ self initializeNewGroup
]

{ #category : #instanceCreation }
Dice class >> newGroup: aDieGroup [
	^ self new initializeWithGroup: aDieGroup
]

{ #category : #initialize }
Dice >> initializeWithGroup: aDieGroup [
	dice := aDieGroup
]

{ #category : #rolling }
Dice >> roll [
	^dice sum: [:die | die roll ].
	
]
