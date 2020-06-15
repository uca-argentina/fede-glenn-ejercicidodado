Class {
	#name : #CardEffect,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #comparing }
CardEffect >> = otherCardEffect [
	^self class = otherCardEffect class
]

{ #category : #comparing }
CardEffect >> == otherCard [
^self class == otherCard class

]

{ #category : #comparing }
CardEffect >> hash [
^self class hash
]
