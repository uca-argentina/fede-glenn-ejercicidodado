Class {
	#name : #DiceTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
DiceTest >> testRollDice [ 
	|result dice dieOne dieTwo|
	dieOne := Die withSides: 6.
	dieTwo := Die withSides: 4.
	dice:= (Dice newGroup addDice: dieOne) addDice:dieTwo.
	result := dice roll.
	self assert: (result between:2 and:10).
]

{ #category : #tests }
DiceTest >> testRollDiceManyTimes [ 
	|result1 result2 dice dieOne dieTwo dieThree|
	dieOne := Die withSides: 6.
	dieTwo := Die withSides: 4.
	dice:= (Dice newGroup addDice: dieOne) addDice:dieTwo.
	result1 := dice roll.
	
	dieThree := Die withSides: 10.
	result2 := (dice addDice: dieThree) roll.
	
	self assert: (result1 between:2 and:10).
	self assert: (result2 between:3 and:20).
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
	|result dice|
	dice:= Die withSides:2.
	1 to: 6 do:[ :i |
	result:= dice roll.
	self assert: (result between:1 and:6)]	
	
]
