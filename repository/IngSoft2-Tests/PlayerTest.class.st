Class {
	#name : 'PlayerTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
PlayerTest >> testWhenAPlayerIsAskedItsNameThenReturnsItsName [

	| aPlayer |
	aPlayer := Player named: 'Juan'.

	self assert: aPlayer name equals: 'Juan'
]

{ #category : 'tests' }
PlayerTest >> testWhenAPlayerThrowsADieThenItMovesTheAmountRolled [

	| aPlayer aDice aGame  aBoard |
	aPlayer := Player named: 'Juan'.
	aBoard := Board withLenght: 20.
	aDice := LoadedDie rolling: 6.

	aGame := Game
		         playedBy: aPlayer
		         onBoard: aBoard
		         withSetOfDie: aDice.

	aPlayer:= aGame movePlayer: aPlayer distance: aDice throw.
	self assert: aPlayer position equals: 7
]
