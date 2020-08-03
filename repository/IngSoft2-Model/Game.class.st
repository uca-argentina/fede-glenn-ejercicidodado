Class {
	#name : #Game,
	#superclass : #Object,
	#instVars : [
		'dice',
		'positionTracker',
		'turnManager',
		'cardManager',
		'lastEffectApplied'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Game class >> withBoard: aBoard dice: aDie players: somePlayers [
	| cards |
	cards := OrderedCollection new.
	somePlayers size * 2 timesRepeat: [ cards add: NoEffectCard new ].
	^ self new
		initializeWithBoard: aBoard
		dice: aDie
		players: somePlayers
		cards: (Deck with: cards)
]

{ #category : #'instance creation' }
Game class >> withBoard: aBoard dice: dice players: aCollectionOfPlayers cards: aCollectionOfCards [ 
	^self new initializeWithBoard: aBoard dice: dice  players: aCollectionOfPlayers cards: aCollectionOfCards 
]

{ #category : #'card application' }
Game >> applyAccelerationCard [
	positionTracker move: (turnManager currentTurnPlayer) havingRolled: 1.
]

{ #category : #'effect application' }
Game >> applyAtomicBombEffect [
	positionTracker moveAllToStart.
]

{ #category : #'effect application' }
Game >> applyCancellationCard: aPermanentCard [ 
	cardManager removeActiveCard: aPermanentCard.
]

{ #category : #'effect application' }
Game >> applyDrawCardEffect [
	cardManager drawCardFor: (turnManager currentTurnPlayer)
]

{ #category : #'effect application' }
Game >> applyMoonWalkEffect: aMoonWalkEffect [
	turnManager allPlayersButActual
		do: [ :aPlayer | 
			positionTracker
				moveBackwards: aPlayer
				spaces: aMoonWalkEffect backingSpaces ]
]

{ #category : #'card application' }
Game >> applyOverloadCard: aPlayer [
	aPlayer = (turnManager currentTurnPlayer)
		ifTrue: [ (cardManager activeCardEffect
				select: [ :aCard | aCard = OverloadCard new ])
				detect: [ :aCard | aCard target = turnManager currentTurnPlayer ]
				ifFound: [ positionTracker
						moveBackwards: turnManager currentTurnPlayer
						spaces: 2 ] ]
]

{ #category : #'card application' }
Game >> applyRedoCard: aRedoCard [ 
	|lastPlayedCard |
	lastPlayedCard := cardManager lastPlayedCard.
	lastPlayedCard isPermanent
		ifTrue: [ cardManager replayLastPermanentEffectTarget: (aRedoCard target) ]
		ifFalse: [ lastPlayedCard applyTo: self.]
]

{ #category : #'card application' }
Game >> applyRepeatCar: aPlayer [
   turnManager specialTurn: aPlayer.
	lastEffectApplied applyTo: self.
	turnManager endSpecialTurn: aPlayer.
	
]

{ #category : #'card application' }
Game >> applySpeedCard: aPlayer [
	aPlayer = turnManager currentTurnPlayer
		ifTrue: [ (cardManager activeCardEffect
				select: [ :aCard | aCard = SpeedCard new ])
				detect: [ :aCard | aCard target = turnManager currentTurnPlayer ]
				ifFound:
					[ positionTracker move: turnManager currentTurnPlayer havingRolled: 1 ] ]
]

{ #category : #'effect application' }
Game >> applySpeedUpEffect [
	positionTracker move: (turnManager currentTurnPlayer) havingRolled: 4.
]

{ #category : #'effect application' }
Game >> applyWormHoleEffect [
	positionTracker moveBackwards: turnManager currentTurnPlayer spaces: 4.
]

{ #category : #accessing }
Game >> checkHandOf: aPlayer [ 
	^cardManager checkHandOf: aPlayer
]

{ #category : #state }
Game >> hasAWinner [
	^ positionTracker isThereAWinner
]

{ #category : #initialization }
Game >> initializeWithBoard: aBoard dice: aDice players: aCollectionOfPlayers cards: aDeck [
	dice := aDice.
	positionTracker := PositionTracker withBoard: aBoard Players: aCollectionOfPlayers.
	turnManager := TurnManager organize: aCollectionOfPlayers asOrderedCollection.
	cardManager := CardManager dealCardsTo: aCollectionOfPlayers with: aDeck.
	lastEffectApplied := NoEffect new.
]

{ #category : #history }
Game >> lastEffectApplied [
	^lastEffectApplied
]

{ #category : #play }
Game >> makePlayOf: aPlayer [ 
	| rolled currentLocker|
	rolled := dice roll.
	positionTracker move: aPlayer havingRolled: rolled.
	cardManager activeCardEffect do: [:aCard | aCard applyTo: self].
	currentLocker := positionTracker positionOf: aPlayer.
	currentLocker effect applyTo: self.
	lastEffectApplied := currentLocker effect.


]

{ #category : #action }
Game >> play: aPlayer [
	turnManager assertIsTurnOf:  aPlayer.
	self makePlayOf: aPlayer. 
	turnManager alreadyPlayed: aPlayer.
]

{ #category : #play }
Game >> playCard: aCard from: aPlayer [
	aCard isPermanent
		ifTrue: [ self playCard: aCard from: aPlayer to: aPlayer ]
		ifFalse: [ aCard applyTo: self.
			cardManager utilizeCard: aCard from: aPlayer ]
]

{ #category : #play }
Game >> playCard: aCard from: aPlayer to: targetedPlayer [
	turnManager assertIsTurnOf: aPlayer.
	cardManager utilizeCard: aCard from: aPlayer to: targetedPlayer
]

{ #category : #accessing }
Game >> positionOf: aPlayer [ 
	^positionTracker positionOf: aPlayer 
]

{ #category : #ranking }
Game >> rankOf: aPlayer [ 
	^positionTracker getPlayersInOrderByLocker indexOf: aPlayer.
]

{ #category : #ranking }
Game >> scoreBoard [
	^positionTracker getPlayersInOrderByLocker  
]
