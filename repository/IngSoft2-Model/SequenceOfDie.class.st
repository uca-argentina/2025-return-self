"
A sequence of die
"
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

{ #category : 'testing' }
SequenceOfDie class >> quantityOfPlayersMustBeGreaterThanOne: aQuantity [

	aQuantity > 1 ifFalse: [
		Error signal: 'The quantity of players must be at least 2.' ]
]

{ #category : 'creation' }
SequenceOfDie class >> withDie: aSequenceOfDie andQuantityOfPlayers: aQuantity [

	self quantityOfPlayersMustBeGreaterThanOne: aQuantity.
	^ self new
		  initializeSequenceOfDie: aSequenceOfDie
		  andQuantityOfPlayers: aQuantity
]

{ #category : 'initialization' }
SequenceOfDie >> initializeSequenceOfDie: aSequenceOfDie andQuantityOfPlayers: aQuantity [

	allDie := aSequenceOfDie.
	currentDiceIndexPlaying := 1.
	quantityOfPlayers := aQuantity.
	currentPlayerIndex := 1
]

{ #category : 'iterator' }
SequenceOfDie >> movePointer [

	currentPlayerIndex := currentPlayerIndex + 1.
	currentPlayerIndex <= quantityOfPlayers ifTrue: [ ^ self ].

	currentPlayerIndex := 1.
	currentDiceIndexPlaying := currentDiceIndexPlaying + 1.
	currentDiceIndexPlaying <= allDie size ifTrue: [ ^ self ].

	currentDiceIndexPlaying := 1
]

{ #category : 'accessing' }
SequenceOfDie >> throw [

	| aResult |
	aResult := (allDie at: currentDiceIndexPlaying) throw.

	self movePointer.

	^ aResult
]
