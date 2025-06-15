Class {
	#name : 'LoadedDieTest',
	#superclass : 'ReturnSelfTestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
LoadedDieTest >> test01WhenThrowingLoadedDieThenReturnsGivenNumber [

	| aLoadedDie |
	aLoadedDie := LoadedDie rolling: 4.

	self assert: aLoadedDie throw equals: 4
]

{ #category : 'tests' }
LoadedDieTest >> test02ThrowMultipleLoadedDie [

	| firstDice secondDice aSetOfDie |
	firstDice := LoadedDie rolling: 6.
	secondDice := LoadedDie rolling: 9.
	aSetOfDie := DieSet having: {
			             firstDice.
			             secondDice }.
	self assert: aSetOfDie throw equals: 15
]

{ #category : 'tests' }
LoadedDieTest >> test03WhenTheGameIsPlayedWithASequenceOfDie [

	| aLoadedDie aSecondLoadedDie aSequence aWormhole aGame firstPlayer secondPlayer aGroupOfPlayers aTestBoard |
	aLoadedDie := LoadedDie rolling: 1.
	aSecondLoadedDie := LoadedDie rolling: 3.
	aSequence := SequenceOfDieForTesting 
		             withDie: {
				             aLoadedDie.
				             aSecondLoadedDie }.
	aWormhole := Wormhole oneEnd: 18 otherEnd: 19.
	firstPlayer := ShipPlayerAssociation createWith: 1 and: 'Juan'.
	secondPlayer := ShipPlayerAssociation createWith: 2 and: 'Tomi'.
	aGroupOfPlayers := {
		                 firstPlayer.
		                 secondPlayer }.
	aTestBoard := BoardForTesting createWithTiles: 20 andEffects: { aWormhole }.
	aGame := Game
		         playedBy: aGroupOfPlayers
		         withBoard: aTestBoard 
		         withSetOfDie: aSequence
					withLaps: 1.

	aGame nextPlayerThrowsDice. "primer jugador tira 1 (posicion 2)"
	aGame nextPlayerThrowsDice. "segundo jugador tira 3 (posicion 4)"
	aGame nextPlayerThrowsDice. "primer jugador tira 1 (posicion 3)"
	aGame nextPlayerThrowsDice. "segundo jugador tira 3 (posicion 7)"

	self assert: aGame nextPlayerThrowsDice equals: 4 "primer jugador tira 1 (posicion 4)"
]
