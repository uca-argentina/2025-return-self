Class {
	#name : 'LoadedDieTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
LoadedDieTest >> testTryingToRollLowerThanOneRaisesAnError [

	| anErrorHandler |
	anErrorHandler := MyErrorHandler usingTestCase: self.
	anErrorHandler
		should: [ LoadedDie rolling: 0 ]
		raiseErrorWithMessageText: 'The roll cant be lower than one.'.
	anErrorHandler
		should: [ LoadedDie rolling: -2 ]
		raiseErrorWithMessageText: 'The roll cant be lower than one.'
]

{ #category : 'tests' }
LoadedDieTest >> testWhenTheGameIsPlayedWithASequenceOfDie [

	| aLoadedDie aSecondLoadedDie aSequence aWormhole aGame |
	aLoadedDie := LoadedDie rolling: 1.
	aSecondLoadedDie := LoadedDie rolling: 3.
	aSequence := SequenceOfDie
		             withDie: {
				             aLoadedDie.
				             aSecondLoadedDie }
		             andQuantityOfPlayers: 2.
	aWormhole := Wormhole oneEnd: 18 otherEnd: 19.
	aGame := GameSetup newGameWithDie: aSequence withWormhole: aWormhole.

	aGame nextPlayerThrowsDice. "primer jugador tira 1 (posicion 2)"
	aGame nextPlayerThrowsDice. "segundo jugador tira 1 (posicion 2)"
	aGame nextPlayerThrowsDice. "primer jugador tira 3 (posicion 5)"
	aGame nextPlayerThrowsDice. "segundo jugador tira 3 (posicion 5)"

	self assert: aGame nextPlayerThrowsDice equals: 6 "primer jugador tira 1 (posicion 6)"
]

{ #category : 'tests' }
LoadedDieTest >> testWhenThrowingLoadedDieThenReturnsGivenNumber [

	| aLoadedDie |
	aLoadedDie := LoadedDie rolling: 4.

	self assert: aLoadedDie throw equals: 4
]
