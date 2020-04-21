Class {
	#name : #BoardTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
BoardTest >> testAddManyPlayers [

	| board playerOne playerTwo |
	
  board := Board withSpaces: 10.
  playerOne := Player called: 'Fede'.
  playerTwo := Player called: 'Glenn'.
  self assert: board numOfPlayers equals: 0.
  board addPlayer: playerOne.
  board addPlayer: playerTwo.
  self assert: board numOfPlayers equals: 2.
]

{ #category : #tests }
BoardTest >> testCreateBoard [

	| board result |
	
	board := Board withSpaces: 6.
	result := board length.
	
	self assert: result equals: 6.
	
	
	
	
	"dice:= LoadedDie withValue:2."
	
]

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
