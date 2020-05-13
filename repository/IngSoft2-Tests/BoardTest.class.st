Class {
	#name : #BoardTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
BoardTest >> testPlayerCanPlay [

	| board playerOne die |
	
  die := LoadedDie withValue: 5.
  board := Board withSpaces: 10 withDice: die.
  playerOne := Player called: 'Fede'.
  board addPlayer: playerOne.
  board play: playerOne.
  self assert: playerOne position equals: 5.
  
  
]

{ #category : #tests }
BoardTest >> testPlayerCanWin [

	| board playerOne die |
	
  die := LoadedDie withValue: 5.
  board := Board withSpaces: 10 withDice: die.
  playerOne := Player called: 'Fede'.
  board addPlayer: playerOne.
  board play: playerOne.
  self assert: playerOne position equals: 5.
  self assert: board hasFinished not.
  board play: playerOne.
  self assert: playerOne position equals: 10.
  self assert: board hasFinished.

  
  
]

{ #category : #tests }
BoardTest >> testPlayerCanWinOverTheLimit [

	| board playerOne die |
	
  die := LoadedDie withValue: 6.
  board := Board withSpaces: 10 withDice: die.
  playerOne := Player called: 'Fede'.
  board addPlayer: playerOne.
  board play: playerOne.
  self assert: playerOne position equals: 6.
  self assert: board hasFinished not.
  board play: playerOne.
  self assert: playerOne position equals: 12.
  self assert: board hasFinished.

  
  
]
