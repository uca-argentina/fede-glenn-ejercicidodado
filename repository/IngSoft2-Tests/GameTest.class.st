Class {
	#name : #GameTest,
	#superclass : #TestCase,
	#instVars : [
		'playerOne',
		'playerTwo',
		'playerThree'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #probability }
GameTest >> elements: elements probability: probabilities amount: amount [
	| result index |
	result := OrderedCollection new.
	index := 1.
	elements size
		timesRepeat: [ result
				add:
					(ProbabilityWrapper
						with: (elements at: index)
						probability: (probabilities at: index)).
			index := index + 1 ].
	^ ProbabilityDistributor new
		createShuffledCollection: result
		defaultElement: NoEffectCard new
		size: amount
]

{ #category : #setup }
GameTest >> fede [
	^'Fede'
]

{ #category : #setup }
GameTest >> glenn [
	^'Glenn'
]

{ #category : #setup }
GameTest >> nicky [
	^ 'Nicky'
]

{ #category : #running }
GameTest >> setUp [
	"Hooks that subclasses may override to define the fixture of test."
	playerOne := 'Fede'.
	playerTwo := 'Glenn'.
	playerThree := 'Nicky'.
]

{ #category : #tests }
GameTest >> testAPlayerPlaysTwiceFails [
	| board playerOne playerTwo die game |
	die := LoadedDie withValue: 6.
	playerOne := self fede.
	playerTwo := self glenn.
	board := Board withSpaces: 10 Laps: 2.
	game := Game
		withBoard: board
		dice: die
		players:
			{playerOne.
			playerTwo}.
	game play: playerOne.
	self should: [ game play: playerOne ] raise: TurnError
]

{ #category : #tests }
GameTest >> testAtomicBombEffect [
	| board die game |
	die := LoadedDie withValue: 4.
	board := Board
		withSpaces: 2
		Laps: 3
		effects: {(ProbabilityWrapper with: AtomicBombEffect new probability: 1)}.
	game := Game withBoard: board dice: die players: {playerOne}.
	game play: playerOne.
	self
		assert: (game positionOf: playerOne)
		equals: (Locker position: 1 lap: 3)
]

{ #category : #tests }
GameTest >> testAtomicBombEffectWithAnotherPlayerInStartingPosition [
	| board  die game |
	die := LoadedDie withValue: 7.
	board := Board
		withSpaces: 5
		Laps: 2
		effects: {(ProbabilityWrapper with: AtomicBombEffect new probability: 1)}.
	game := Game
		withBoard: board
		dice: die
		players:
			{playerOne.
			playerTwo}.
	game play: playerOne.
	self
		assert: (game positionOf: playerOne)
		equals: (Locker position: 1 lap: 2).
	self
		assert: (game positionOf: playerTwo)
		equals: (Locker position: 1 lap: 1)
]

{ #category : #tests }
GameTest >> testCancellationCard [
	| board die game deckOfCards cancellationCard cards |
	die := LoadedDie withValue: 1.
	cards := self
		elements: {SpeedCard new . CancellationCard new} probability: {0.5 . 0.5} amount: 30.
	deckOfCards := Deck with: cards.
	board := Board
		withSpaces: 100
		Laps: 1
		effects: {(ProbabilityWrapper with: DrawCardEffect new probability: 1)}.
	game := Game
		withBoard: board
		dice: die
		players:
			{playerOne.
			playerTwo}
		cards: deckOfCards.
	10
		timesRepeat: [ game play: playerOne.
			game play: playerTwo ].
	game playCard: SpeedCard new from: playerOne to: playerTwo.
	game play: playerOne.
	cancellationCard := CancellationCard new
		target: (SpeedCard new target: playerTwo).
	game playCard: cancellationCard from: playerOne.
	game play: playerTwo.
	self
		assert: (game positionOf: playerTwo)
		equals: (Locker position: 12 lap: 1).
	self
		assert: (game positionOf: playerOne)
		equals: (Locker position: 12 lap: 1)
]

{ #category : #tests }
GameTest >> testCancellationCardWithNoPermanentCardsActive [
	| board die game deckOfCards cancellation |
	die := LoadedDie withValue: 1.
	deckOfCards := Deck
		with: (self elements: {CancellationCard new} probability: {0.5} amount: 30).
	board := Board
		withSpaces: 10
		Laps: 1
		effects: {(ProbabilityWrapper with: DrawCardEffect new probability: 1)}.
	game := Game
		withBoard: board
		dice: die
		players: {playerOne}
		cards: deckOfCards.
	cancellation := CancellationCard new target: SpeedCard new.
	self
		should: [ game playCard: cancellation from: playerOne ]
		raise: MissingActiveCardEffect
]

{ #category : #tests }
GameTest >> testCancellationCardWithTwoEqualActiveEffects [
	| board die game deckOfCards cards |
	die := LoadedDie withValue: 1.
	playerOne := self fede.
	playerTwo := self glenn.
	cards := self
		elements: {SpeedCard new . CancellationCard new} probability: {0.5 . 0.5} amount: 30.
	deckOfCards := Deck with: cards.
	board := Board
		withSpaces: 100
		Laps: 1
		effects: {(ProbabilityWrapper with: DrawCardEffect new probability: 1)}.
	game := Game
		withBoard: board
		dice: die
		players:
			{playerOne.
			playerTwo}
		cards: deckOfCards.
	10
		timesRepeat: [ game play: playerOne.
			game play: playerTwo ].
	game playCard: SpeedCard new from: playerOne to: playerTwo.
	game play: playerOne.
	game playCard: SpeedCard new from: playerTwo to: playerTwo.
	game
		playCard: (CancellationCard new target: (SpeedCard new target: playerTwo))
		from: playerOne.
	game play: playerTwo.
	self
		assert: (game positionOf: playerTwo)
		equals: (Locker position: 13 lap: 1).
	self
		assert: (game positionOf: playerOne)
		equals: (Locker position: 12 lap: 1)
]

{ #category : #tests }
GameTest >> testCannotPlayCardThatIsNotInHand [
	| board die game deckOfCards |
	die := LoadedDie withValue: 2.
	deckOfCards := Deck with: {NoEffectCard new . NoEffectCard new}.
	board := Board withSpaces: 5 Laps: 1.
	game := Game
		withBoard: board
		dice: die
		players: {playerOne}
		cards: deckOfCards.
	self
		should: [ game playCard: AccelerationCard new from: playerOne ]
		raise: EmptyDeckError
]

{ #category : #tests }
GameTest >> testCannotPlayPermanentCardOutOfTurn [
	| board die game deckOfCards |
	die := LoadedDie withValue: 2.
	deckOfCards := Deck
		with:
			{AccelerationCard new.
			AccelerationCard new.
			AccelerationCard new.
			AccelerationCard new}.
	board := Board withSpaces: 5 Laps: 1.
	game := Game
		withBoard: board
		dice: die
		players:
			{playerOne.
			playerTwo}
		cards: deckOfCards.
	self
		should: [ game playCard: AccelerationCard new from: playerTwo ]
		raise: TurnError
]

{ #category : #tests }
GameTest >> testCompleteOneLap [
	| board die game|
	die := LoadedDie withValue: 6.
	board := Board withSpaces:10 Laps: 2.
	game := Game
		withBoard: board
		dice: die
		players: {playerOne}.
	game play: playerOne.
	game play: playerOne.
	self assert: (game positionOf: playerOne) equals: (Locker position: 3 lap: 2).
]

{ #category : #tests }
GameTest >> testDrawCardEffect [
	| board die game deckOfCards |
	die := LoadedDie withValue: 2.
	deckOfCards := Deck
		with:
			{NoEffectCard new.
			NoEffectCard new.
			NoEffectCard new}.
	board := Board
		withSpaces: 5
		Laps: 1
		effects: {(ProbabilityWrapper with: DrawCardEffect new probability: 1)}.
	game := Game
		withBoard: board
		dice: die
		players: {playerOne}
		cards: deckOfCards.
	game play: playerOne.
	self assert: (game checkHandOf: playerOne) size equals: 3
]

{ #category : #tests }
GameTest >> testGameScoreBoard [
	| board die result game |
	die := LoadedDie withValue: 6.
	board := Board withSpaces: 10 Laps: 2.
	game := Game
		withBoard: board
		dice: die
		players:
			{playerOne.
			playerTwo}.
	game play: playerOne.
	game play: playerTwo.
	game play: playerOne.
	result := {playerOne.
	playerTwo} asOrderedCollection.
	self assert: result equals: game scoreBoard
]

{ #category : #tests }
GameTest >> testHandOutTwoCardsInitially [
	| game board die deckOfCards |
	die := LoadedDie withValue: 5.
	board := Board withSpaces: 10 Laps: 2.
	deckOfCards := Deck withCards: {NoEffectCard new . NoEffectCard new}.
	game := Game
		withBoard: board
		dice: die
		players: {playerOne}
		cards: deckOfCards.
	self assert: (game checkHandOf: playerOne) size equals: 2
]

{ #category : #tests }
GameTest >> testMoonWalkEffect [
	| board die game |
	die := LoadedDie withValue: 6.
	board := Board
		withSpaces: 10
		Laps: 1
		effects: {(ProbabilityWrapper with: (MoonWalkEffect goBack: 2) probability: 1)}.
	game := Game
		withBoard: board
		dice: die
		players:
			{playerOne.
			playerTwo}.
	game play: playerOne.
	game play: playerTwo.
	self
		assert: (game positionOf: playerOne)
		equals: (Locker position: 5 lap: 1).
	self
		assert: (game positionOf: playerTwo)
		equals: (Locker position: 7 lap: 1)
]

{ #category : #tests }
GameTest >> testNoEffect [
	| board die game |
	die := LoadedDie withValue: 3.
	board := Board
		withSpaces: 10
		Laps: 1
		effects: {(ProbabilityWrapper with: NoEffect new probability: 1)}.
	game := Game withBoard: board dice: die players: {playerOne}.
	game play: playerOne.
	self
		assert: (game positionOf: playerOne)
		equals: (Locker position: 4 lap: 1)
]

{ #category : #tests }
GameTest >> testPlayCard [
	| board die game deckOfCards |
	die := LoadedDie withValue: 2.
	deckOfCards := Deck with: {NoEffectCard new . NoEffectCard new}.
	board := Board withSpaces: 5 Laps: 1.
	game := Game
		withBoard: board
		dice: die
		players: {playerOne}
		cards: deckOfCards.
	game play: playerOne.
	game playCard: NoEffectCard new from: playerOne.
	self assert: (game checkHandOf: playerOne) size equals: 1
]

{ #category : #tests }
GameTest >> testPlayCardAcceleration [
	| board die game deckOfCards |
	die := LoadedDie withValue: 2.
	deckOfCards := Deck
		with:
			{AccelerationCard new.
			AccelerationCard new.
			AccelerationCard new.
			AccelerationCard new}.
	board := Board withSpaces: 5 Laps: 1.
	game := Game
		withBoard: board
		dice: die
		players:
			{playerOne.
			playerTwo}
		cards: deckOfCards.
	game playCard: AccelerationCard new from: playerOne.
	game play: playerOne.
	game play: playerTwo.
	self
		assert: (game positionOf: playerTwo)
		equals: (Locker position: 4 lap: 1).
	self
		assert: (game positionOf: playerOne)
		equals: (Locker position: 4 lap: 1)
]

{ #category : #tests }
GameTest >> testPlayCardAfterDeckIsEmpty [
	| board die game deckOfCards |
	die := LoadedDie withValue: 2.
	deckOfCards := Deck
		with:
			{NoEffectCard new.
			NoEffectCard new}.
	board := Board
		withSpaces: 10
		Laps: 1
		effects: {(ProbabilityWrapper with: DrawCardEffect new probability: 1)}.
	game := Game
		withBoard: board
		dice: die
		players: {playerOne}
		cards: deckOfCards.

	game playCard: NoEffectCard new from: playerOne.
	game playCard: NoEffectCard new from: playerOne.
	game play: playerOne.
	
	self assert: (game checkHandOf: playerOne) size equals: 1.
]

{ #category : #tests }
GameTest >> testPlayOverloadCard [
	| board die game deckOfCards |
	die := LoadedDie withValue: 5.
	deckOfCards := Deck
		with:
			{OverloadCard new.
			OverloadCard new.
			OverloadCard new.
			OverloadCard new}.
	board := Board withSpaces: 6 Laps: 2.
	game := Game
		withBoard: board
		dice: die
		players:
			{playerOne.
			playerTwo}
		cards: deckOfCards.
	game playCard: OverloadCard new from: playerOne to: playerTwo.
	game play: playerOne.
	game play: playerTwo.
	self
		assert: (game positionOf: playerTwo)
		equals: (Locker position: 4 lap: 1).
	self
		assert: (game positionOf: playerOne)
		equals: (Locker position: 6 lap: 1)
]

{ #category : #tests }
GameTest >> testPlaySpeedCard [
	| board die game deckOfCards |
	die := LoadedDie withValue: 2.
	deckOfCards := Deck
		with:
			{SpeedCard new.
			SpeedCard new.
			SpeedCard new.
			SpeedCard new}.
	board := Board withSpaces: 5 Laps: 1.
	game := Game
		withBoard: board
		dice: die
		players:
			{playerOne.
			playerTwo}
		cards: deckOfCards.
	game playCard: SpeedCard new from: playerOne to: playerTwo.
	game play: playerOne.
	game play: playerTwo.
	self
		assert: (game positionOf: playerTwo)
		equals: (Locker position: 4 lap: 1).
	self
		assert: (game positionOf: playerOne)
		equals: (Locker position: 3 lap: 1)
]

{ #category : #tests }
GameTest >> testPlayWithSeveralCards [
	| board die game deckOfCards finalHand cards |
	die := LoadedDie withValue: 1.
	cards := self elements: {NoEffectCard new . OverloadCard new} probability: {0.5 . 0.5} amount: 100.
	deckOfCards := Deck with: cards.
	board := Board
		withSpaces: 100
		Laps: 1
		effects: {(ProbabilityWrapper with: DrawCardEffect new probability: 1)}.
	game := Game
		withBoard: board
		dice: die
		players: {playerOne}
		cards: deckOfCards.
	90 timesRepeat: [ game play: playerOne ].
	finalHand := game checkHandOf: playerOne.
	self assert: finalHand size equals: 92.
	self
		assert: (finalHand anySatisfy: [ :aCard | aCard = NoEffectCard new ]).
	self
		assert: (finalHand anySatisfy: [ :aCard | aCard = OverloadCard new ])
]

{ #category : #tests }
GameTest >> testPlayerDoesNotCrossLastLocker [
	| board die game |
	die := LoadedDie withValue: 12.
	board := Board withSpaces: 10 Laps: 1.
	game := Game withBoard: board dice: die players: {playerOne}.
	game play: playerOne.
	self
		assert: (game positionOf: playerOne)
		equals: board lastLocker
]

{ #category : #tests }
GameTest >> testPlayerPlays [
	| game board die |
	die := LoadedDie withValue: 5.
	board := Board withSpaces: 10 Laps: 2.
	game := Game withBoard: board dice: die players: {playerOne}.
	game play: playerOne.
	self
		assert: (game positionOf: playerOne)
		equals: (Locker position: 6 lap: 1)
]

{ #category : #tests }
GameTest >> testPlayerRank [
	| board die game |
	die := LoadedDie withValue: 6.
	board := Board withSpaces: 10 Laps: 1.
	game := Game
		withBoard: board
		dice: die
		players:
			{playerOne.
			playerTwo}.
	game play: playerOne.
	game play: playerTwo.
	game play: playerOne.
	self assert: (game rankOf: playerOne) equals: 1.
	self assert: (game rankOf: playerTwo) equals: 2
]

{ #category : #tests }
GameTest >> testPlayerWins [
	| board die game |
	die := LoadedDie withValue: 6.
	board := Board withSpaces: 10 Laps: 1.
	game := Game withBoard: board dice: die players: {playerOne}.
	game play: playerOne.
	self assert: game hasAWinner not.
	game play: playerOne.
	self
		assert: (game positionOf: playerOne)
		equals: board lastLocker.
	self assert: game hasAWinner
]

{ #category : #tests }
GameTest >> testPlayingWithTurnsWithThreePlayers [
	| board die game |
	die := LoadedDie withValue: 6.
	board := Board withSpaces: 10 Laps: 1.
	game := Game
		withBoard: board
		dice: die
		players:
			{playerOne.
			playerTwo.
			playerThree}.
	game play: playerOne.
	self
		assert: (game positionOf: playerOne)
		equals: (Locker position: 7 lap: 1).
	game play: playerTwo.
	self
		assert: (game positionOf: playerOne)
		equals: (Locker position: 7 lap: 1).
	game play: playerThree.
	self
		assert: (game positionOf: playerOne)
		equals: (Locker position: 7 lap: 1).
	game play: playerOne.
	self assert: game hasAWinner
]

{ #category : #tests }
GameTest >> testRedoInstantCard [
	| board die game deckOfCards cards |
	die := LoadedDie withValue: 1.
	cards := self
		elements:
			{RedoCard new.
			CancellationCard new.
			SpeedCard new}
		probability: {0.4 . 0.3 . 0.3}
		amount: 300.
	deckOfCards := Deck with: cards.
	board := Board
		withSpaces: 100
		Laps: 1
		effects: {(ProbabilityWrapper with: DrawCardEffect new probability: 1)}.
	game := Game
		withBoard: board
		dice: die
		players:
			{playerOne.
			playerTwo}
		cards: deckOfCards.
	100
		timesRepeat: [ game play: playerOne.
			game play: playerTwo ].
	game playCard: SpeedCard new from: playerOne to: playerOne.
	game playCard: SpeedCard new from: playerOne to: playerOne.
	game
		playCard: (CancellationCard new target: (SpeedCard new target: playerOne))
		from: playerTwo.
	game
		playCard: (RedoCard new target: (SpeedCard new target: playerOne))
		from: playerTwo.
	game play: playerOne.
	self
		assert: (game positionOf: playerTwo)
		equals: (Locker position: 100 lap: 1 effect: DrawCardEffect new).
	self
		assert: (game positionOf: playerOne)
		equals: (Locker position: 100 lap: 1 effect: DrawCardEffect new)
]

{ #category : #tests }
GameTest >> testRedoPermanentCard [
	| board die game deckOfCards redoCard cards |
	die := LoadedDie withValue: 1.
	cards := self
		elements:
			{SpeedCard new.
			RedoCard new}
		probability: {0.5 . 0.5}
		amount: 210.
	deckOfCards := Deck with: cards.
	board := Board
		withSpaces: 150
		Laps: 1
		effects: {(ProbabilityWrapper with: DrawCardEffect new probability: 1)}.
	game := Game
		withBoard: board
		dice: die
		players:
			{playerOne.
			playerTwo}
		cards: deckOfCards.
	100
		timesRepeat: [ game play: playerOne.
			game play: playerTwo ].
	game playCard: SpeedCard new from: playerOne to: playerTwo.
	game play: playerOne.
	redoCard := RedoCard new target: playerOne.
	game playCard: redoCard from: playerOne.
	game play: playerTwo.
	game play: playerOne.
	self
		assert: (game positionOf: playerTwo)
		equals: (Locker position: 103 lap: 1 effect: DrawCardEffect new).
	self
		assert: (game positionOf: playerOne)
		equals: (Locker position: 104 lap: 1 effect: DrawCardEffect new)
]

{ #category : #tests }
GameTest >> testRedoPermanentCardOverload [
	| board die game deckOfCards redoCard cards |
	die := LoadedDie withValue: 1.
	cards := self
		elements:
			{OverloadCard new.
			RedoCard new}
		probability: {0.5 . 0.5}
		amount: 250.
	deckOfCards := Deck with: cards.
	board := Board
		withSpaces: 1000
		Laps: 1
		effects: {(ProbabilityWrapper with: DrawCardEffect new probability: 1)}.
	game := Game
		withBoard: board
		dice: die
		players:
			{playerOne.
			playerTwo}
		cards: deckOfCards.
	100
		timesRepeat: [ game play: playerOne.
			game play: playerTwo ].
	game playCard: OverloadCard new from: playerOne to: playerTwo.
	game play: playerOne.
	redoCard := RedoCard new target: playerOne.
	game playCard: redoCard from: playerOne.
	game play: playerTwo.
	game play: playerOne.
	self
		assert: (game positionOf: playerTwo)
		equals: (Locker position: 100 lap: 1 effect: DrawCardEffect new).
	self
		assert: (game positionOf: playerOne)
		equals: (Locker position: 101 lap: 1 effect: DrawCardEffect new)
]

{ #category : #tests }
GameTest >> testRepeatMoonWalkEffect [
	| board die game deckOfCards cards |
	die := LoadedDie withValue: 8.
	cards := self
		elements: {RepeatCard new}
		probability: {1}
		amount: 50.
	deckOfCards := Deck with: cards.
	board := Board
		withSpaces: 100
		Laps: 1
		effects: {(ProbabilityWrapper with: (MoonWalkEffect goBack: 2) probability: 1)}.
	game := Game
		withBoard: board
		dice: die
		players:
			{playerOne.
			playerTwo}
		cards: deckOfCards.
	game play: playerOne.
	game play: playerTwo.
	game playCard: (RepeatCard new target: playerOne) from: playerOne.
	self
		assert: (game positionOf: playerOne)
		equals: (Locker position: 7 lap: 1 effect: MoonWalkEffect new).
	self
		assert: (game positionOf: playerTwo)
		equals: (Locker position: 7 lap: 1 effect: MoonWalkEffect new)
]

{ #category : #tests }
GameTest >> testRepeatSpeedupEffect [
	| board die game deckOfCards cards |
	die := LoadedDie withValue: 1.
	cards := self
		elements: {RepeatCard new}
		probability: {1}
		amount: 50.
	deckOfCards := Deck with: cards.
	board := Board
		withSpaces: 100
		Laps: 1
		effects: {(ProbabilityWrapper with: SpeedUpEffect new probability: 1)}.
	game := Game
		withBoard: board
		dice: die
		players:
			{playerOne.
			playerTwo}
		cards: deckOfCards.
	game play: playerOne.
	game playCard: (RepeatCard new target: playerTwo) from: playerTwo.
	self
		assert: (game positionOf: playerOne)
		equals: (Locker position: 6 lap: 1).
	self
		assert: (game positionOf: playerTwo)
		equals: (Locker position: 5 lap: 1)
]

{ #category : #tests }
GameTest >> testSpeedUpEffect [
	| board die game |
	die := LoadedDie withValue: 1.
	board := Board
		withSpaces: 10
		Laps: 1
		effects: {(ProbabilityWrapper with: SpeedUpEffect new probability: 1)}.
	game := Game withBoard: board dice: die players: {playerOne}.
	game play: playerOne.
	self
		assert: (game positionOf: playerOne)
		equals: (Locker position: 6 lap: 1)
]

{ #category : #tests }
GameTest >> testTargetTwoCardAtAPlayer [
	| board die game deckOfCards cards |
	die := LoadedDie withValue: 1.
	cards := self
		elements: {SpeedCard new}
		probability: {1}
		amount: 50.
	deckOfCards := Deck with: cards.
	board := Board
		withSpaces: 100
		Laps: 1
		effects: {(ProbabilityWrapper with: DrawCardEffect new probability: 1)}.
	game := Game
		withBoard: board
		dice: die
		players:
			{playerOne.
			playerTwo}
		cards: deckOfCards.
	game playCard: SpeedCard new from: playerOne to: playerTwo.
	game play: playerOne.
	game playCard: SpeedCard new from: playerTwo to: playerTwo.
	game play: playerTwo.
	self
		assert: (game positionOf: playerTwo)
		equals: (Locker position: 4 lap: 1).
	self
		assert: (game positionOf: playerOne)
		equals: (Locker position: 2 lap: 1)
]

{ #category : #tests }
GameTest >> testWormHoleEffect [
	| board die game |
	die := LoadedDie withValue: 6.
	board := Board
		withSpaces: 10
		Laps: 1
		effects: {(ProbabilityWrapper with: WormHoleEffect new probability: 1)}.
	game := Game withBoard: board dice: die players: {playerOne}.
	game play: playerOne.
	self
		assert: (game positionOf: playerOne)
		equals: (Locker position: 3 lap: 1)
]

{ #category : #tests }
GameTest >> testWormHoleEffectLimitMove [
	| board die game |
	die := LoadedDie withValue: 3.
	board := Board
		withSpaces: 10
		Laps: 1
		effects: {(ProbabilityWrapper with: WormHoleEffect new probability: 1)}.
	game := Game withBoard: board dice: die players: {playerOne}.
	game play: playerOne.
	self
		assert: (game positionOf: playerOne)
		equals: (Locker position: 1 lap: 1)
]
