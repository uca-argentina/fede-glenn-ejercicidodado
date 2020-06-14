Class {
	#name : #GameTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
GameTest >> testAPlayerPlaysTwiceFails [
	| board playerOne playerTwo die game|
	die := LoadedDie withValue: 6.
	playerOne := Player called: 'Fede'.
	playerTwo := Player called: 'Glenn'.
	board := Board withSpaces:10 Laps: 2.
	game := Game
		withBoard: board
		dice: die
		players: (Array with: playerOne with: playerTwo).
	game play: playerOne.
	self
		should: [ game play: playerOne ]
		raise: TurnError
]

{ #category : #tests }
GameTest >> testAtomicBombEffect [
	| board playerOne die game |
	playerOne := Player called: 'Fede'.
	die := LoadedDie withValue: 4.
	board := Board
		withSpaces: 2
		Laps: 3
		effects: (Array with: (AtomicBombEffect withProbability: 1)).
	game := Game
		withBoard: board
		dice: die
		players: (Array with: playerOne).
	
	game play: playerOne.
	self assert: (game inWhichPositionIs: playerOne) equals: (Locker position: 1 lap: 3).


]

{ #category : #tests }
GameTest >> testAtomicBombEffectWithAnotherPlayerInStartingPosition [
	| board playerOne die game playerTwo |
	playerOne := Player called: 'Fede'.
	playerTwo := Player called: 'Glenn'.
	die := LoadedDie withValue: 7.
	board := Board
		withSpaces: 5
		Laps: 2
		effects: (Array with: (AtomicBombEffect withProbability: 1)).
	game := Game
		withBoard: board
		dice: die
		players: (Array with: playerOne with: playerTwo).
	
	game play: playerOne.
	self assert: (game inWhichPositionIs: playerOne) equals: (Locker position: 1 lap: 2).
	self assert: (game inWhichPositionIs: playerTwo) equals: (Locker position: 1 lap: 1).


]

{ #category : #tests }
GameTest >> testCannotPlayCardOutOfTurn [
	| board playerOne die game deckOfCards playerTwo |
	die := LoadedDie withValue: 2.
	playerOne := Player called: 'Fede'.
	playerTwo := Player called: 'Glenn'.
	deckOfCards := Deck withCards: (Array with: AccelerationCard new).
	board := Board withSpaces: 5 Laps: 1.
	game := Game
		withBoard: board
		Dice: die
		Players: (Array with: playerOne with: playerTwo)
		cards: deckOfCards.
		self
		should: [ game playCard: AccelerationCard new from: playerTwo ]
		raise: TurnError
]

{ #category : #tests }
GameTest >> testCannotPlayCardThatIsNotInHand [
	| board playerOne die game deckOfCards |
	die := LoadedDie withValue: 2.
	playerOne := Player called: 'Fede'.
	deckOfCards := Deck withCards:(Array with: NoEffectCard new).
	board := Board
		withSpaces: 5
		Laps: 1.
	game := Game
		withBoard: board
		Dice: die
		Players: (Array with: playerOne)
		cards: deckOfCards.
		self
		should: [ game playCard: AccelerationCard new from: playerOne ]
		raise: MissingCardError
]

{ #category : #tests }
GameTest >> testCompleteOneLap [
	| board playerOne die game|
	die := LoadedDie withValue: 6.
	playerOne := Player called: 'Fede'.
	board := Board withSpaces:10 Laps: 2.
	game := Game
		withBoard: board
		dice: die
		players: (Array with: playerOne).
	game play: playerOne.
	game play: playerOne.
	self assert: (game inWhichPositionIs: playerOne) equals: (Locker position: 3 lap: 2).
]

{ #category : #tests }
GameTest >> testDrawCardEffect [
	| board playerOne die game deckOfCards |
	die := LoadedDie withValue: 2.
	playerOne := Player called: 'Fede'.
	deckOfCards := Deck withCards: (Array with: NoEffectCard new).
	board := Board
		withSpaces: 5
		Laps: 1
		effects: (Array with: (DrawCardEffect withProbability: 1)).
	game := Game
		withBoard: board
		Dice: die
		Players: (Array with: playerOne)
		cards: deckOfCards.
	game play: playerOne.
	self assert: (game checkHandOf: playerOne) size equals: 3
]

{ #category : #tests }
GameTest >> testGameScoreBoard [
	| board playerOne playerTwo die result game|
	die := LoadedDie withValue: 6.
	playerOne := Player called: 'Fede'.
	playerTwo := Player called: 'Glenn'.
	board := Board withSpaces: 10 Laps: 2.
	game := Game
		withBoard: board
		dice: die
		players: (Array with: playerOne with: playerTwo).
	game play: playerOne.
	game play: playerTwo.
	game play: playerOne.
	
	result := OrderedCollection new.
	result add: playerOne.
	result add: playerTwo.
	
	self assert: result equals: game scoreBoard
]

{ #category : #tests }
GameTest >> testHandOutTwoCardsInitially [
	| game board playerOne die deckOfCards |
	die := LoadedDie withValue: 5.
	playerOne := Player called: 'Fede'.
	board := Board withSpaces:10 Laps: 2.
	deckOfCards := Deck withCards:(Array with: NoEffectCard new).
	game := Game
		withBoard: board
		Dice: die
		Players: (Array with: playerOne)
		cards: deckOfCards.
	self assert: (game checkHandOf: playerOne) size equals: 2.
]

{ #category : #tests }
GameTest >> testMoonWalkEffect [
	| board playerOne playerTwo die game |
	playerOne := Player called: 'Fede'.
	playerTwo := Player called: 'Glenn'.
	die := LoadedDie withValue: 6.
	board := Board
		withSpaces: 10
		Laps: 1
		effects: (Array with: (MoonWalkEffect withProbability: 1 goBack: 2)).
	game := Game
		withBoard: board
		dice: die
		players: (Array with: playerOne with: playerTwo).
	
	game play: playerOne.
	game play: playerTwo. 
	self assert: (game inWhichPositionIs: playerOne) equals: (Locker position: 5 lap: 1).
	self assert: (game inWhichPositionIs: playerTwo) equals: (Locker position: 7 lap: 1).

]

{ #category : #tests }
GameTest >> testNoEffect [
	| board playerOne die game |
	die := LoadedDie withValue: 3.
	playerOne := Player called: 'Fede'.
	board := Board
		withSpaces: 10
		Laps: 1
		effects: (Array with: (NoEffect withProbability: 1)).
	game := Game
		withBoard: board
		dice: die
		players: (Array with: playerOne).
		
	game play: playerOne.
	self assert: (game inWhichPositionIs: playerOne) equals: (Locker position: 4 lap:1).
	





]

{ #category : #tests }
GameTest >> testPlayCard [
	| board playerOne die game deckOfCards |
	die := LoadedDie withValue: 2.
	playerOne := Player called: 'Fede'.
	deckOfCards := Deck withCards:(Array with: NoEffectCard new).
	board := Board
		withSpaces: 5
		Laps: 1.
	game := Game
		withBoard: board
		Dice: die
		Players: (Array with: playerOne)
		cards: deckOfCards.
	game play: playerOne.
	game playCard: NoEffectCard new from: playerOne.
	self assert: (game checkHandOf: playerOne) size equals: 1
]

{ #category : #tests }
GameTest >> testPlayCardAcceleration [
	| board playerOne die game deckOfCards playerTwo |
	die := LoadedDie withValue: 2.
	playerOne := Player called: 'Fede'.
	playerTwo := Player called: 'Glenn'.
	deckOfCards := Deck withCards: (Array with: AccelerationCard new).
	board := Board withSpaces: 5 Laps: 1.
	game := Game
		withBoard: board
		Dice: die
		Players: (Array with: playerOne with: playerTwo)
		cards: deckOfCards.
	game playCard: AccelerationCard new from: playerOne.
	game play: playerOne.
	game play: playerTwo.
	self
		assert: (game inWhichPositionIs: playerTwo)
		equals: (Locker position: 4 lap: 1).
	self
		assert: (game inWhichPositionIs: playerOne)
		equals: (Locker position: 4 lap: 1)
]

{ #category : #tests }
GameTest >> testPlayWithSeveralCards [
	| board playerOne die game deckOfCards finalHand |
	die := LoadedDie withValue: 1.
	deckOfCards := Deck withCards: (Array with: NoEffectCard new with: OverloadCard new).
	playerOne := Player called: 'Fede'.
	board := Board
		withSpaces: 100
		Laps: 1
		effects: (Array with: (DrawCardEffect withProbability: 1)).
	game := Game 
		withBoard: board
		Dice: die
		Players: (Array with: playerOne)
		cards: deckOfCards.
	90 timesRepeat: [game play: playerOne].
	finalHand := game checkHandOf: playerOne.
	self assert: (finalHand size) equals: 92.
	self
		assert: (finalHand anySatisfy: [ :aCard | aCard = NoEffectCard new ]).
	self
		assert: (finalHand anySatisfy: [ :aCard | aCard = OverloadCard new ])
]

{ #category : #tests }
GameTest >> testPlayerDoesNotCrossLastLocker [
	|board playerOne die game|
	die := LoadedDie withValue: 12.
	playerOne := Player called: 'Fede'.
	board := Board withSpaces: 10 Laps: 1.
	game := Game
		withBoard: board
		dice: die
		players: (Array with: playerOne).
	game play: playerOne.
	self assert: (game inWhichPositionIs: playerOne) equals: (board lastLocker).
]

{ #category : #tests }
GameTest >> testPlayerPlays [
	| game board playerOne die |
	die := LoadedDie withValue: 5.
	playerOne := Player called: 'Fede'.
	board := Board withSpaces:10 Laps: 2.
	game := Game
		withBoard: board
		dice: die
		players: (Array with: playerOne).
	game play: playerOne.
	self assert: (game inWhichPositionIs: playerOne) equals: (Locker position: 6 lap: 1).
	
]

{ #category : #tests }
GameTest >> testPlayerRank [
	| board playerOne playerTwo die game|
	playerOne := Player called: 'Fede'.
	playerTwo := Player called: 'Glenn'.
	die := LoadedDie withValue: 6.
	board := Board withSpaces: 10 Laps: 1.
	game := Game
		withBoard: board
		dice: die
		players: (Array with: playerOne with:playerTwo).
	game play: playerOne.
	game play: playerTwo.
	game play: playerOne.
	
	self assert: (game rankOf: playerOne) equals: 1.
	self assert: (game rankOf: playerTwo) equals: 2.
]

{ #category : #tests }
GameTest >> testPlayerWins [
	| board playerOne die game |
	die := LoadedDie withValue: 6.
	playerOne := Player called: 'Fede'.
	board := Board withSpaces: 10 Laps: 1.
	game := Game
		withBoard: board
		dice: die
		players: (Array with: playerOne).
	game play: playerOne.
	self assert: game hasAWinner not.
	game play: playerOne.
	self
		assert: (game inWhichPositionIs: playerOne)
		equals: board lastLocker.
	self assert: game hasAWinner
]

{ #category : #tests }
GameTest >> testPlayingWithTurnsWithThreePlayers [
	| board playerOne playerTwo playerThree die game |
	playerOne := Player called: 'Fede'.
	playerTwo := Player called: 'Glenn'.
	playerThree := Player called: 'Nicky'.
	die := LoadedDie withValue: 6.
	board := Board withSpaces: 10 Laps: 1.
	game := Game
		withBoard: board
		dice: die
		players: (Array with: playerOne with:playerTwo with: playerThree ).
	game play: playerOne.
	self assert: (game inWhichPositionIs: playerOne) equals: (Locker position:7 lap:1).
	game play: playerTwo.
	self assert: (game inWhichPositionIs: playerOne) equals: (Locker position:7 lap:1).
	game play: playerThree.
	self assert: (game inWhichPositionIs: playerOne) equals: (Locker position:7 lap:1).
	game play: playerOne.
	self assert: game hasAWinner 
]

{ #category : #tests }
GameTest >> testSpeedUp [
	| board playerOne die game |
	die := LoadedDie withValue: 1.
	playerOne := Player called: 'Fede'.
	board := Board
		withSpaces: 10
		Laps: 1
		effects: (Array with: (SpeedUpEffect withProbability: 1)).
	game := Game
		withBoard: board
		dice: die
		players: (Array with: playerOne).
	game play: playerOne.
	
	self assert: (game inWhichPositionIs: playerOne)  equals: (Locker position: 6 lap: 1).
]

{ #category : #tests }
GameTest >> testWormHoleEffect [
	| board playerOne die game |
	die := LoadedDie withValue: 6.
	playerOne := Player called: 'Fede'.
	board := Board
		withSpaces: 10
		Laps: 1
		effects: (Array with: (WormHoleEffect withProbability: 1)).
	game := Game
		withBoard: board
		dice: die
		players: (Array with: playerOne).
	game play: playerOne.
	
	self assert: (game inWhichPositionIs: playerOne)  equals: (Locker position: 3 lap: 1).
]

{ #category : #tests }
GameTest >> testWormHoleEffectLimitMove [
	| board playerOne die game |
	die := LoadedDie withValue: 3.
	playerOne := Player called: 'Fede'.
	board := Board
		withSpaces: 10
		Laps: 1
		effects: (Array with: (WormHoleEffect withProbability: 1)).
	game := Game
		withBoard: board
		dice: die
		players: (Array with: playerOne).
	game play: playerOne.
	
	self assert: (game inWhichPositionIs: playerOne)  equals: (Locker position: 1 lap: 1).
]
