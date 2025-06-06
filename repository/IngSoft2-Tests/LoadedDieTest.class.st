Class {
	#name : 'LoadedDieTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
LoadedDieTest >> testTryingToRollLowerThanOneRaisesAnError [

	| anErrorHandler |
	anErrorHandler := ReturnSelfErrorHandler usingTestCase: self.
	anErrorHandler
		should: [ LoadedDie rolling: 0 ]
		raiseErrorWithMessageText: 'The roll cant be lower than one.'.
	anErrorHandler
		should: [ LoadedDie rolling: -2 ]
		raiseErrorWithMessageText: 'The roll cant be lower than one.'
]

{ #category : 'tests' }
LoadedDieTest >> testWhenTheGameIsPlayedWithASequenceOfDie [

	| aLoadedDie aSecondLoadedDie aSequence aWormhole aGame firstPlayer secondPlayer aSetOfPlayers boardLength |
	aLoadedDie := LoadedDie rolling: 1.
	aSecondLoadedDie := LoadedDie rolling: 3.
	aSequence := SequenceOfDieForTesting 
		             withDie: {
				             aLoadedDie.
				             aSecondLoadedDie }.
	aWormhole := Wormhole oneEnd: 18 otherEnd: 19.
	firstPlayer := Player named: 'Juan'.
	secondPlayer := Player named: 'Tomi'.
	aSetOfPlayers := {
		                 firstPlayer.
		                 secondPlayer }.
	boardLength := 20.
	aGame := Game
		         playedBy: aSetOfPlayers
		         withBoardLength: boardLength
		         withEffect: aWormhole
		         withSetOfDie: aSequence.

	aGame nextPlayerThrowsDice. "primer jugador tira 1 (posicion 2)"
	aGame nextPlayerThrowsDice. "segundo jugador tira 3 (posicion 4)"
	aGame nextPlayerThrowsDice. "primer jugador tira 1 (posicion 3)"
	aGame nextPlayerThrowsDice. "segundo jugador tira 3 (posicion 7)"

	self assert: aGame nextPlayerThrowsDice equals: 4 "primer jugador tira 1 (posicion 4)"
]

{ #category : 'tests' }
LoadedDieTest >> testWhenThrowingLoadedDieThenReturnsGivenNumber [

	| aLoadedDie |
	aLoadedDie := LoadedDie rolling: 4.

	self assert: aLoadedDie throw equals: 4
]
