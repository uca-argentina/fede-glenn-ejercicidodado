Class {
	#name : #CardEffect,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #comparing }
CardEffect >> = otherCardEffect [
	^self class = otherCardEffect class
]

{ #category : #operations }
CardEffect >> applyTo: aGame [
	^ self subclassResponsibility
]
