Class {
	#name : #BoardTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
BoardTest >> testAPlayerPlaysTwiceFails [
	| board playerOne playerTwo die |
	die := LoadedDie withValue: 6.
	board := Board withSpaces: 10 withDice: die.
	playerOne := Player called: 'Fede'.
	playerTwo := Player called: 'Glenn'.
	board addPlayer: playerOne.
	board addPlayer: playerTwo.
	board play: playerOne.
	self
		should: [ board play: playerOne ]
		raise: TurnError
		description: 'This is not the player turn'
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
	self assert: board hasFinished
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
	self assert: board hasFinished
]

{ #category : #tests }
BoardTest >> testPlayerPosition [
	| board playerOne playerTwo playerThree die result |
	die := LoadedDie withValue: 6.
	board := Board withSpaces: 10 withDice: die.
	playerOne := Player called: 'Fede'.
	playerTwo := Player called: 'Glenn'.
	playerThree := Player called: 'Nicky'.
	board addPlayer: playerOne.
	board addPlayer: playerTwo.
	board addPlayer: playerThree.
	board play: playerOne.
	board play: playerTwo.
	board play: playerThree.
	board play: playerOne.
	result := OrderedCollection new.
	result add: playerOne.
	result add: playerTwo.
	result add: playerThree.
	self assert: result equals: board scoreBoard
]

{ #category : #tests }
BoardTest >> testPlayingWithTurns [
	| board playerOne playerTwo die |
	die := LoadedDie withValue: 6.
	board := Board withSpaces: 10 withDice: die.
	playerOne := Player called: 'Fede'.
	playerTwo := Player called: 'Glenn'.
	board addPlayer: playerOne.
	board addPlayer: playerTwo.
	board play: playerOne.
	self assert: playerOne position equals: 6.
	board play: playerTwo.
	self assert: playerTwo position equals: 6.
	board play: playerOne.
	self assert: board winner equals: playerOne
]

{ #category : #tests }
BoardTest >> testPlayingWithTurnsWithThreePlayers [
	| board playerOne playerTwo playerThree die |
	die := LoadedDie withValue: 6.
	board := Board withSpaces: 10 withDice: die.
	playerOne := Player called: 'Fede'.
	playerTwo := Player called: 'Glenn'.
	playerThree := Player called: 'Nicky'.
	board addPlayer: playerOne.
	board addPlayer: playerTwo.
	board addPlayer: playerThree.
	board play: playerOne.
	self assert: playerOne position equals: 6.
	board play: playerTwo.
	self assert: playerTwo position equals: 6.
	board play: playerThree.
	self assert: playerThree position equals: 6.
	board play: playerOne.
	self assert: board winner equals: playerOne
]
