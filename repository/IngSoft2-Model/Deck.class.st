Class {
	#name : #Deck,
	#superclass : #Object,
	#instVars : [
		'deck'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Deck class >> withCards: aCollectionOfCards [ 
	^self new initializeWithCards: aCollectionOfCards
]

{ #category : #accessing }
Deck >> drawCard [
	| topCard |
	topCard := deck first.
	self shuffle.
	^ topCard
]

{ #category : #initialization }
Deck >> initializeWithCards: aCollectionOfCards [ 
	deck := aCollectionOfCards asOrderedCollection.
]

{ #category : #shuffling }
Deck >> shuffle [
	deck shuffle
]
