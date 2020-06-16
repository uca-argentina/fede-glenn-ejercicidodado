Class {
	#name : #RedoCard,
	#superclass : #CardEffect,
	#instVars : [
		'target'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'effect applcation' }
RedoCard >> applyTo: aGame [ 
	aGame applyRedoCard: self.
]

{ #category : #classification }
RedoCard >> isPermanent [
	^false
]

{ #category : #targeting }
RedoCard >> target [
	^ target
]

{ #category : #targeting }
RedoCard >> target: anObject [ 
	target := anObject
]
