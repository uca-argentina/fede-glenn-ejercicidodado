Class {
	#name : #BoardTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
BoardTest >> testAPlayerPlaysTwiceFails [
	| board playerOne playerTwo die |
	die := LoadedDie withValue: 6.
	playerOne := Player called: 'Fede'.
	playerTwo := Player called: 'Glenn'.
	board := Board
		withSpaces: 10
		withDice: die
		withPlayers: (Array with: playerOne with: playerTwo)
		withLaps: 2.
	board play: playerOne.
	self
		should: [ board play: playerOne ]
		raise: TurnError
		description: 'This is not the player turn'
]

{ #category : #tests }
BoardTest >> testCircularBoard [
	| board playerOne die |
	die := LoadedDie withValue: 6.
	playerOne := Player called: 'Fede'.
	board := Board
		withSpaces: 10
		withDice: die
		withPlayers: (Array with: playerOne)
		withLaps: 2.
	board play: playerOne.
	board play: playerOne.
	self assert: board hasFinished not.
	self assert: playerOne position equals: 2.
]

{ #category : #tests }
BoardTest >> testPlayerCanWinOverTheLimit [
	| board playerOne die |
	die := LoadedDie withValue: 6.
	playerOne := Player called: 'Fede'.
	board := Board
		withSpaces: 10
		withDice: die
		withPlayers: (Array with: playerOne)
		withLaps: 1.
	board play: playerOne.
	self assert: playerOne position equals: 6.
	self assert: board hasFinished not.
	board play: playerOne.
	self assert: playerOne position equals: 10.
	self assert: board hasFinished
]

{ #category : #tests }
BoardTest >> testPlayerEndInLastPosition [
	| board playerOne die |
	die := LoadedDie withValue: 6.
	playerOne := Player called: 'Fede'.
	board := Board
		withSpaces: 10
		withDice: die
		withPlayers: (Array with: playerOne)
		withLaps: 1.
	board play: playerOne.
	self assert: playerOne position equals: 6.
	self assert: board hasFinished not.
	board play: playerOne.
	self assert: playerOne position equals: 10.
	self assert: board hasFinished
]

{ #category : #tests }
BoardTest >> testPlayerPlays [
	| board playerOne die |
	die := LoadedDie withValue: 5.
	playerOne := Player called: 'Fede'.
	board := Board
		withSpaces: 10
		withDice: die
		withPlayers: (Array with: playerOne)
		withLaps: 2.
	board play: playerOne.
	self assert: playerOne position equals: 5
]

{ #category : #tests }
BoardTest >> testPlayerPosition [
	| board playerOne playerTwo playerThree die result |
	die := LoadedDie withValue: 6.
	playerOne := Player called: 'Fede'.
	playerTwo := Player called: 'Glenn'.
	playerThree := Player called: 'Nicky'.
	board := Board
		withSpaces: 10
		withDice: die
		withPlayers: (Array with: playerOne with: playerTwo with: playerThree)
		withLaps: 2.
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
BoardTest >> testPlayerRank [
	| board playerOne playerTwo die |
	playerOne := Player called: 'Fede'.
	playerTwo := Player called: 'Glenn'.
	die := LoadedDie withValue: 6.
	board := Board
		withSpaces: 10
		withDice: die
		withPlayers: (Array with: playerOne with: playerTwo )
		withLaps: 1.
	board play: playerOne.
	self assert: playerOne position equals: 6.
	board play: playerTwo.
	self assert: playerTwo position equals: 6.
	board play: playerOne.
	self assert: playerOne rank equals: 1.
	self assert: playerTwo rank equals: 2.
]

{ #category : #tests }
BoardTest >> testPlayerWins [
	| board playerOne die |
	die := LoadedDie withValue: 5.
	playerOne := Player called: 'Fede'.
	board := Board
		withSpaces: 10
		withDice: die
		withPlayers: (Array with: playerOne)
		withLaps: 1.
	board play: playerOne.
	self assert: playerOne position equals: 5.
	self assert: board hasFinished not.
	board play: playerOne.
	self assert: playerOne position equals: 10.
	self assert: board hasFinished
]

{ #category : #tests }
BoardTest >> testPlayingWithTurns [
	| board playerOne playerTwo die |
	die := LoadedDie withValue: 6.
	playerOne := Player called: 'Fede'.
	playerTwo := Player called: 'Glenn'.
	board := Board
		withSpaces: 10
		withDice: die
		withPlayers: (Array with: playerOne with: playerTwo)
		withLaps: 1.
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
	playerOne := Player called: 'Fede'.
	playerTwo := Player called: 'Glenn'.
	playerThree := Player called: 'Nicky'.
	die := LoadedDie withValue: 6.
	board := Board
		withSpaces: 10
		withDice: die
		withPlayers: (Array with: playerOne with: playerTwo with: playerThree)
		withLaps: 1.
	board play: playerOne.
	self assert: playerOne position equals: 6.
	board play: playerTwo.
	self assert: playerTwo position equals: 6.
	board play: playerThree.
	self assert: playerThree position equals: 6.
	board play: playerOne.
	self assert: board winner equals: playerOne
]
