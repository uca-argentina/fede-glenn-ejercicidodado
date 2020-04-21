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

{ #category : #adding }
Dice class >> addDice: aDie [ 
	dice add: aDie.
]

{ #category : #instanceCreation }
Dice class >> newGroup [
	dice := OrderedCollection new.
]

{ #category : #rolling }
Dice class >> roll [
	|sum|
	sum:=0.
	dice do: [:die | sum := sum + (die roll). ].
	^sum
]

{ #category : #'instance creation - old' }
Dice class >> withAmount: anInteger [ 
	dice := Array new:anInteger.
]

{ #category : #'instance creation' }
Dice class >> withDie: aDie withDie: aDie2 [ 
	self shouldBeImplemented.
]

{ #category : #adding }
Dice >> addDice: aDie [ 
	dice add: aDie.
	
]
