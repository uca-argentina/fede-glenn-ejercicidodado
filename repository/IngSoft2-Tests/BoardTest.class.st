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
BoardTest >> testAtomicBombEffectStaysSameLaps [
	| board playerOne playerTwo die |
	playerOne := Player called: 'Fede'.
	playerTwo := Player called: 'Glenn'.
	die := LoadedDie withValue: 6.
	
	board := PracticeBoard
		withSpaces: 10
		withDice: die
		withPlayers: (Array with: playerOne with: playerTwo)
		withLaps: 3
		withEffect: (Array with: (AtomicBombEffect withProbability: 1)).
	board set: playerOne toPosition: 0 toLap: 1.
	board set: playerTwo toPosition: 8 toLap: 3.
	
	board play: playerOne.
	self assert: playerOne currentLap equals: 1.
	self assert: playerTwo currentLap equals: 3.

]

{ #category : #tests }
BoardTest >> testAtomicBombEffectToStartingPosition [
	| board playerOne playerTwo die |
	playerOne := Player called: 'Fede'.
	playerTwo := Player called: 'Glenn'.
	die := LoadedDie withValue: 6.
	
	board := PracticeBoard
		withSpaces: 10
		withDice: die
		withPlayers: (Array with: playerOne with: playerTwo)
		withLaps: 1
		withEffect: (Array with: (AtomicBombEffect withProbability: 1)).
	board set: playerOne toPosition: 0 toLap: 1.
	board set: playerTwo toPosition: 8 toLap: 1.
	
	board play: playerOne.
	self assert: playerOne position equals: 0.
	self assert: playerTwo position equals: 0.

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
BoardTest >> testMoonWalkEffect [
	| board playerOne playerTwo die |
	playerOne := Player called: 'Fede'.
	playerTwo := Player called: 'Glenn'.
	die := LoadedDie withValue: 6.
	
	board := PracticeBoard
		withSpaces: 10
		withDice: die
		withPlayers: (Array with: playerOne with: playerTwo)
		withLaps: 1
		withEffect: (Array with: (MoonWalkEffect withProbability: 1)).
	board set: playerOne toPosition: 0 toLap: 1.
	board set: playerTwo toPosition: 8 toLap: 1.
	
	board play: playerOne.
	self assert: playerOne position equals: 6.
	self assert: playerTwo position equals: 5.

]

{ #category : #tests }
BoardTest >> testNoEffect [
	| board playerOne die |
	die := LoadedDie withValue: 3.
	playerOne := Player called: 'Fede'.
	board := Board
		withSpaces: 10
		withDice: die
		withPlayers: (Array with: playerOne)
		withLaps: 1
		withEffect: (Array with: (NoEffect withProbability: 1)).
	board play: playerOne.
	self assert: playerOne position equals: 3.
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

{ #category : #tests }
BoardTest >> testSetAPlayerInSpecificPosition [
	| board playerOne playerTwo die |
	playerOne := Player called: 'Fede'.
	playerTwo := Player called: 'Glenn'.
	die := LoadedDie withValue: 6.
	
	board := PracticeBoard
		withSpaces: 10
		withDice: die
		withPlayers: (Array with: playerOne with: playerTwo)
		withLaps: 5.
	board set: playerOne toPosition: 3 toLap: 1.
	board set: playerTwo toPosition: 8 toLap: 1.

	self assert: playerOne position equals: 3.
	self assert: playerTwo position equals: 8.
	
	board play: playerOne.
	board play: playerTwo.
	
	self assert: playerOne position equals: 9.
	self assert: playerTwo position equals: 4.
	self assert: playerTwo currentLap equals: 2.
	
	

]

{ #category : #tests }
BoardTest >> testSpeedUp [
	| board playerOne die |
	die := LoadedDie withValue: 3.
	playerOne := Player called: 'Fede'.
	board := Board
		withSpaces: 10
		withDice: die
		withPlayers: (Array with: playerOne)
		withLaps: 1
		withEffect: (Array with: (SpeedUpEffect withProbability: 1)).
	board play: playerOne.
	self assert: playerOne position equals: 7.
]

{ #category : #tests }
BoardTest >> testWormHoleEffect [
	| board playerOne die |
	die := LoadedDie withValue: 6.
	playerOne := Player called: 'Fede'.
	board := Board
		withSpaces: 10
		withDice: die
		withPlayers: (Array with: playerOne)
		withLaps: 1
		withEffect: (Array with: (WormHoleEffect withProbability: 1)).
	board play: playerOne.
	self assert: playerOne position equals: 2.
]

{ #category : #tests }
BoardTest >> testWormholeEffectProbability [
	| board playerOne die lastPosition wormHoleCounter noEffectCounter |
	die := LoadedDie withValue: 4.
	wormHoleCounter := 0.
	noEffectCounter := 0.
	playerOne := Player called: 'Fede'.
	board := Board
		withSpaces: 1000
		withDice: die
		withPlayers: (Array with: playerOne)
		withLaps: 10
		withEffect: (Array with: (WormHoleEffect withProbability: 0.4)).
	lastPosition := 0.
	1000
		timesRepeat: [ board play: playerOne.
			playerOne position = lastPosition
				ifTrue: [ wormHoleCounter := wormHoleCounter + 1 ]
				ifFalse: [ noEffectCounter := noEffectCounter + 1 ].
			lastPosition := playerOne position ].
	self assert: (wormHoleCounter between: 350 and: 450).
	self assert: 1000 - wormHoleCounter equals: noEffectCounter
]
