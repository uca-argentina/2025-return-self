Class {
	#name : 'DiceTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
DiceTest >> testCreationOfDice [

	| anErrorHandler |
	anErrorHandler := ReturnSelfErrorHandler usingTestCase: self.
	anErrorHandler
		should: [ Dice faces: -10 ]
		raiseErrorWithMessageText:
		'The number of faces must be greater than two.'
]

{ #category : 'tests' }
DiceTest >> testThrowDice [

	| aDice |
	aDice := Dice faces: 6.
	self assert: (aDice throw between: 1 and: 6)
]

{ #category : 'tests' }
DiceTest >> testThrowMultipleDie [

	| firstDice secondDice aSetOfDie |
	firstDice := Dice faces: 6.
	secondDice := Dice faces: 9.
	aSetOfDie := DieSet having: {
			             firstDice.
			             secondDice }.
	self assert: (aSetOfDie throw between: 2 and: 15)
]

{ #category : 'tests' }
DiceTest >> testThrowMultipleLoadedDie [

	| firstDice secondDice aSetOfDie |
	firstDice := LoadedDie rolling: 6.
	secondDice := LoadedDie rolling: 9.
	aSetOfDie := DieSet having: {
			             firstDice.
			             secondDice }.
	self assert: aSetOfDie throw equals: 15
]

{ #category : 'tests' }
DiceTest >> testWhenTheGameIsPlayedWithASequenceOfDie [

	| aLoadedDie aSecondLoadedDie aSequence aWormhole aGame firstPlayer secondPlayer aSetOfPlayers boardLength |
	aLoadedDie := LoadedDie rolling: 1.
	aSecondLoadedDie := LoadedDie rolling: 3.
	aSequence := SequenceOfDie
		             withDie: {
				             aLoadedDie.
				             aSecondLoadedDie }
				andQuantityOfPlayers: 2.
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
		         withWormhole: aWormhole
		         withSetOfDie: aSequence.

	aGame nextPlayerThrowsDice. "primer jugador tira 1 (posicion 2)"
	aGame nextPlayerThrowsDice. "segundo jugador tira 1 (posicion 2)"
	aGame nextPlayerThrowsDice. "primer jugador tira 3 (posicion 5)"
	aGame nextPlayerThrowsDice. "segundo jugador tira 3 (posicion 5)"

	self assert: aGame nextPlayerThrowsDice equals: 6 "primer jugador tira 1 (posicion 6)"
]
