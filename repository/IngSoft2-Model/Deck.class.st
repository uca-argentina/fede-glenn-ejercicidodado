Class {
	#name : #Deck,
	#superclass : #Object,
	#instVars : [
		'deck'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #instantiation }
Deck class >> with: aCollectionOfCards [
	^ self new initializeWithCards: aCollectionOfCards
]

{ #category : #'instance creation' }
Deck class >> withCards: aCollectionOfCards [ 
	^self new initializeWithCards: aCollectionOfCards
]

{ #category : #accessing }
Deck >> cardsLeft [
	^ deck size
]

{ #category : #accessing }
Deck >> drawCard [
	deck isEmpty ifTrue:[MissingCardError signal: 'No more cards in the deck'].
	^ deck removeFirst
]

{ #category : #initialization }
Deck >> initializeWithCards: aCollectionOfCards [ 
	deck := aCollectionOfCards asOrderedCollection.
]

{ #category : #'as yet unclassified' }
Deck >> putAtBottom: aCard [  
	deck addLast: aCard
]

{ #category : #shuffling }
Deck >> shuffle [
	deck shuffle
]

{ #category : #merging }
Deck >> shuffleWith: aDeck [ 
	aDeck cardsLeft timesRepeat: [ self putAtBottom: aDeck drawCard ].
	^self shuffle
	 
]
