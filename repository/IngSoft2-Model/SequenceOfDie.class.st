Class {
	#name : 'SequenceOfDie',
	#superclass : 'Object',
	#instVars : [
		'allDie',
		'currentDiceIndexPlaying',
		'quantityOfPlayers',
		'currentPlayerIndex'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
SequenceOfDie class >> withDie: aSequenceOfDie [ 
	^ self new initializeSequenceOfDie: aSequenceOfDie.
]

{ #category : 'as yet unclassified' }
SequenceOfDie class >> withDie: aSequenceOfDie andQuantityOfPlayers: aQuantity [ 
	^ self new initializeSequenceOfDie: aSequenceOfDie andQuantityOfPlayers: aQuantity .
]

{ #category : 'initialization' }
SequenceOfDie >> initializeSequenceOfDie: aSequenceOfDie andQuantityOfPlayers: aQuantity [ 
	allDie := aSequenceOfDie.
	currentDiceIndexPlaying := 1.
	quantityOfPlayers := aQuantity .
	currentPlayerIndex := 1.
]

{ #category : 'as yet unclassified' }
SequenceOfDie >> movePointer [

	currentPlayerIndex := currentPlayerIndex + 1.
	currentPlayerIndex <= quantityOfPlayers ifTrue: [ ^self ].

	currentPlayerIndex := 1.
	currentDiceIndexPlaying := currentDiceIndexPlaying + 1.
	currentDiceIndexPlaying <= allDie size ifTrue: [ ^self ].

	currentDiceIndexPlaying := 1.
]

{ #category : 'accessing' }
SequenceOfDie >> throw [
	| result |
	result:= (allDie at: currentDiceIndexPlaying) throw.
	
	self movePointer.
	
	^result.
	
]
