Class {
	#name : #CardEffect,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #comparing }
CardEffect >> = otherCardEffect [
	^self class = otherCardEffect class
]
