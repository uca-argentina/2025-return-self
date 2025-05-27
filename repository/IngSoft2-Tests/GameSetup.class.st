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
GameSetup class >> newGameWithDie: aSetOfDie withWormhole: aWormhole [

	| gameSetupObject |
	gameSetupObject := self new.
	^ gameSetupObject initializeGameSetupWithDie: aSetOfDie withWormhole: aWormhole
]

{ #category : 'initialization' }
GameSetup >> initializeGameSetupWithDie: aSetOfDie withWormhole: aWormhole [

	| firstPlayer secondPlayer aSetOfPlayers aGame|
	firstPlayer := Player named: 'Juan'.
	secondPlayer := Player named: 'Tomi'.
	aSetOfPlayers := {
		                 firstPlayer.
		                 secondPlayer }.

	aGame := Game playedBy: aSetOfPlayers withBoardLength: 20 withWormhole:aWormhole withSetOfDie: aSetOfDie.
	
	^aGame.
]
