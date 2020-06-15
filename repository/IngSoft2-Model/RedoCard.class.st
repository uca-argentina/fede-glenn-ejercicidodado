Class {
	#name : #RedoCard,
	#superclass : #CardEffect,
	#instVars : [
		'target'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #applcation }
RedoCard >> applyTo: aGame [ 
	aGame applyRedoCard: self.
]

{ #category : #'as yet unclassifiedclassification' }
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
