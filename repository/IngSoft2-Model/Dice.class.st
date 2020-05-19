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

{ #category : #instanceCreation }
Dice class >> newGroup: aDieGroup [
	^ self new initializeWithGroup: aDieGroup
]

{ #category : #initialize }
Dice >> initializeWithGroup: aDieGroup [
	dice := aDieGroup
]

{ #category : #action }
Dice >> roll [
	^dice sum: [:die | die roll ].
	
]
