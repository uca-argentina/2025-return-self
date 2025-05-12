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

	| aPlayer aDice |
	aPlayer := Player named: 'Juan'.
	aDice := LoadedDie rolling: 6.

	aPlayer move: aDice throw.

	self assert: aPlayer position equals: 7
]
