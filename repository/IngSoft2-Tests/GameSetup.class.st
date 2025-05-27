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
GameSetup class >> newGameWithDie: aSetOfDie withWormhole: wormhole [

	| gameSetupObject |
	gameSetupObject := self new.
	^ gameSetupObject initializeGameSetupWithDie: aSetOfDie withWormhole: wormhole
]

{ #category : 'initialization' }
GameSetup >> initializeGameSetupWithDie: aSetOfDie withWormhole: wormhole [

	| firstPlayer secondPlayer aSetOfPlayers aGame|
	firstPlayer := Player named: 'Juan'.
	secondPlayer := Player named: 'Tomi'.
	aSetOfPlayers := {
		                 firstPlayer.
		                 secondPlayer }.

	aGame := Game playedBy: aSetOfPlayers withBoardLength: 20 withWormhole:wormhole withSetOfDie: aSetOfDie.
	
	^aGame.
]
