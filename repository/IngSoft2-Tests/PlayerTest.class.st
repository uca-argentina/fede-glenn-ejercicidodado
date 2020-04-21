Class {
	#name : #PlayerTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
PlayerTest >> testPlayerRollsDice [

| result dice dieOne dieTwo playerOne |
	dieOne := Die withSides: 6.
	dieTwo := Die withSides: 4.
	dice:= (Dice newGroup addDice: dieOne) addDice:dieTwo.
	playerOne := Player called: 'Fede'.
	result:= playerOne roll: dice. "Como es polimorfica con Die entiende con 1 dado o muchos"
	
	self assert: (result between:2 and:10).
]

{ #category : #tests }
PlayerTest >> testPlayerRollsDie [

| result playerOne dieOne |

playerOne := Player called: 'Fede'.
dieOne := Die withSides: 6.
result := playerOne roll: dieOne.

self assert: (result between: 1 and: 6).
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

playerOne rollAndAdvance: dieOne.

self assert: playerOne position equals: 6.

playerOne rollAndAdvance: dieOne.

self assert: playerOne position equals: 12.


]
