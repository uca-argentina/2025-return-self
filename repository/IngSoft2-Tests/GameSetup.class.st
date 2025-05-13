"
A Game mock object used in several tests
"
Class {
	#name : 'GameSetup',
	#superclass : 'Object',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'instance creation' }
GameSetup class >> newGame [

	| gameSetupObject |
	gameSetupObject := self new.
	^ gameSetupObject initializeGameSetupWithAnEffect: NoEffect new
]

{ #category : 'instance creation' }
GameSetup class >> newGameWithWormhole: wormhole [

	| gameSetupObject |
	gameSetupObject := self new.
	^ gameSetupObject initializeGameSetupWithAnEffect: wormhole
]

{ #category : 'initialization' }
GameSetup >> initializeGameSetupWithAnEffect: anEffect [

	| firstPlayer secondPlayer aSetOfPlayers aBoard aGame aSetOfDie firstDice secondDice|
	firstPlayer := Player named: 'Juan'.
	secondPlayer := Player named: 'Tomi'.
	firstDice := LoadedDie rolling: 6.
	secondDice := LoadedDie rolling: 9.
	aSetOfDie := DieSet having: {
			             firstDice.
			             secondDice }.
	aSetOfPlayers := {
		                 firstPlayer.
		                 secondPlayer }.
	aBoard := Board withLenght: 20 and: anEffect.

	aGame := Game playedBy: aSetOfPlayers onBoard: aBoard withSetOfDie: aSetOfDie .
	
	^aGame.
]
