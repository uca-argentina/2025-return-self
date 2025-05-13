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
	|gameSetupObject|
	gameSetupObject := self new.
	^gameSetupObject gameSetup.
]

{ #category : 'instance creation' }
GameSetup class >> newGameWithWormhole: wormhole [
	|gameSetupObject|
	gameSetupObject := self new.
	^gameSetupObject gameSetupWithWormhole:wormhole.
]

{ #category : 'as yet unclassified' }
GameSetup >> gameSetup [

	| firstPlayer secondPlayer aSetOfPlayers aBoard aGame aSetOfDie firstDice secondDice|
	firstPlayer := Player named: 'Juan'.
	secondPlayer := Player named: 'Tomi'.
	aSetOfPlayers := {
		                 firstPlayer.
		                 secondPlayer }.
	aBoard := Board withLenght: 20.
	firstDice := LoadedDie rolling: 6.
	secondDice := LoadedDie rolling: 9.
	aSetOfDie := DieSet having: {
			             firstDice.
			             secondDice }.

	aGame := Game playedBy: aSetOfPlayers onBoard: aBoard withSetOfDie: aSetOfDie .
	
	^aGame.
]

{ #category : 'as yet unclassified' }
GameSetup >> gameSetupWithWormhole: wormhole [

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
	aBoard := Board withLenght: 20 and: wormhole.

	aGame := Game playedBy: aSetOfPlayers onBoard: aBoard withSetOfDie: aSetOfDie .
	
	^aGame.
]
