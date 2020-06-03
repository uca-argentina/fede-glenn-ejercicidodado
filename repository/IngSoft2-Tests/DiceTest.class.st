Class {
	#name : #DiceTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
DiceTest >> testNoNegativeDie [
	self should: [LoadedDie withValue:-2] raise: CreationError.
	self should: [Die withSides:-2] raise: CreationError
	
	
]

{ #category : #tests }
DiceTest >> testRollDice [ 
	|result dice dieOne dieTwo dieGroup |
	dieOne := Die withSides: 6.
	dieTwo := Die withSides: 4.
	dieGroup := OrderedCollection new.
	dieGroup add: dieOne.
	dieGroup add: dieTwo.
	dice:= Dice newGroup: dieGroup.
	result := dice roll.
	self assert: (result between:2 and:10).
]

{ #category : #tests }
DiceTest >> testRollDiceTwo [
	|result dice|
	dice:= LoadedDie withValue:2.
	result:= dice roll.
	self assert: result equals: 2.	
	
]

{ #category : #tests }
DiceTest >> testRollRandomDice [
	| result dice |
	dice := Die withSides: 2.
	6
		timesRepeat: [ result := dice roll.
			self assert: (result between: 1 and: 6) ]
]
