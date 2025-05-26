Class {
	#name : 'LoadedDieTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
LoadedDieTest >> testWhenTheGameIsPlayedWithASequenceOfDie [


| aLoadedDie aSecondLoadedDie aSequence noEffect aGame |
aLoadedDie := LoadedDie rolling: 1.
aSecondLoadedDie := LoadedDie rolling: 3.
aSequence := SequenceOfDie withDie: { aLoadedDie. aSecondLoadedDie } andQuantityOfPlayers: 2.
noEffect := NoEffect new.
aGame := GameSetup newGameWithDie: aSequence withWormhole: noEffect.

aGame nextPlayerThrowsDice. "primer jugador tira 1 (posicion 2)"
aGame nextPlayerThrowsDice. "segundo jugador tira 1 (posicion 2)"
aGame nextPlayerThrowsDice. "primer jugador tira 3 (posicion 5)"
aGame nextPlayerThrowsDice. "segundo jugador tira 3 (posicion 5)"

	self
		assert: (aGame nextPlayerThrowsDice) "primer jugador tira 1 (posicion 6)"
		equals: 6.
]

{ #category : 'tests' }
LoadedDieTest >> testWhenThrowingLoadedDieThenReturnsGivenNumber [

	| aLoadedDie |
	aLoadedDie := LoadedDie rolling: 4.

	self assert: aLoadedDie throw equals: 4
]
