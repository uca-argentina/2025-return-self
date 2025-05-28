Class {
	#name : 'SequenceOfDieForTesting',
	#superclass : 'Object',
	#instVars : [
		'allDie',
		'currentDiceIndexPlaying'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'as yet unclassified' }
SequenceOfDieForTesting class >> withDie: aSequenceOfDie [ 
	^ self new initializeSequenceOfDie: aSequenceOfDie.
]

{ #category : 'as yet unclassified' }
SequenceOfDieForTesting class >> withDie: aSequenceOfDie andQuantityOfPlayers: aQuantity [ 
	^ self new initializeSequenceOfDie: aSequenceOfDie andQuantityOfPlayers: aQuantity .
]

{ #category : 'initialization' }
SequenceOfDieForTesting >> initializeSequenceOfDie: aSequenceOfDie [
	allDie := aSequenceOfDie.
	currentDiceIndexPlaying := 1.

]

{ #category : 'as yet unclassified' }
SequenceOfDieForTesting >> movePointer [

	currentDiceIndexPlaying := currentDiceIndexPlaying + 1.
	currentDiceIndexPlaying <= allDie size ifTrue: [ ^ self ].

	currentDiceIndexPlaying := 1
]

{ #category : 'accessing' }
SequenceOfDieForTesting >> throw [
	| result |
	result:= (allDie at: currentDiceIndexPlaying) throw.
	
	self movePointer.
	
	^result.
	
]
