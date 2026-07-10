"
A mock object that allows to throw diferent values at each turn
"
Class {
	#name : 'LoadedSequenceOfThrows',
	#superclass : 'Object',
	#instVars : [
		'throwSequence',
		'nextThrowIndex'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'creation' }
LoadedSequenceOfThrows class >> createWith: aSequenceOfThrows [

	self validate: aSequenceOfThrows.
	^ self new initializeWith: aSequenceOfThrows
]

{ #category : 'validation' }
LoadedSequenceOfThrows class >> validate: aSequenceOfThrows [

	aSequenceOfThrows isEmpty ifTrue: [
		Error signal: 'There should be at least one throw in the sequence.' ]
]

{ #category : 'initialization' }
LoadedSequenceOfThrows >> initializeWith: aSequenceOfThrows [

	nextThrowIndex := 0.
	throwSequence := aSequenceOfThrows
]

{ #category : 'calculating' }
LoadedSequenceOfThrows >> throw [

	nextThrowIndex := nextThrowIndex \\ throwSequence size + 1.
	^ (throwSequence at: nextThrowIndex) throw
]
