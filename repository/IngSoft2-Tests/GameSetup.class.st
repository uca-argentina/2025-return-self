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

	| firstPlayer secondPlayer aSetOfPlayers aBoard aGame|
	firstPlayer := Player named: 'Juan'.
	secondPlayer := Player named: 'Tomi'.
	aSetOfPlayers := {
		                 firstPlayer.
		                 secondPlayer }.
	aBoard := Board withLenght: 20.

	aGame := Game playedBy: aSetOfPlayers onBoard: aBoard.
	
	^aGame.
]

{ #category : 'as yet unclassified' }
GameSetup >> gameSetupWithWormhole: wormhole [

	| firstPlayer secondPlayer aSetOfPlayers aBoard aGame|
	firstPlayer := Player named: 'Juan'.
	secondPlayer := Player named: 'Tomi'.
	aSetOfPlayers := {
		                 firstPlayer.
		                 secondPlayer }.
	aBoard := Board withLenght: 20 withWormhole: wormhole.

	aGame := Game playedBy: aSetOfPlayers onBoard: aBoard.
	
	^aGame.
]
