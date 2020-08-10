Class {
	#name : #GameEffect,
	#superclass : #Object,
	#instVars : [
		'probability'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #comparing }
GameEffect >> = otherEffect [
	^self class == otherEffect class
]
