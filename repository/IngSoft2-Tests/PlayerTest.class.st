Class {
	#name : #PlayerTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
PlayerTest >> testPlayerRollsDice [
	| result dice dieOne dieTwo playerOne dieGroup |
	dieOne := Die withSides: 6.
	dieTwo := Die withSides: 4.
	dieGroup := OrderedCollection new.
	dieGroup add: dieOne.
	dieGroup add: dieTwo.
	dice:= Dice newGroup: dieGroup.
	playerOne := Player called: 'Fede'.
	result := playerOne roll: dice.
	self assert: (result between: 2 and: 10)
]

{ #category : #tests }
PlayerTest >> testPlayerRollsDie [
	| result playerOne dieOne |
	playerOne := Player called: 'Fede'.
	dieOne := Die withSides: 6.
	result := playerOne roll: dieOne.
	self assert: (result between: 1 and: 6)
]

{ #category : #tests }
PlayerTest >> testPlayerRollsLoadedDie [

| result playerOne dieOne |

playerOne := Player called: 'Fede'.
dieOne := LoadedDie withValue: 6.
result := playerOne roll: dieOne.

self assert: result equals: 6.
]

{ #category : #tests }
PlayerTest >> testPlayerRollsLoadedDieAndAdvances [
	| playerOne dieOne |
	playerOne := Player called: 'Fede'.
	dieOne := LoadedDie withValue: 6.
	self assert: playerOne position equals: 0.
	playerOne move: dieOne roll.
	self assert: playerOne position equals: 6.
	playerOne move: dieOne roll.
	self assert: playerOne position equals: 12.
]
