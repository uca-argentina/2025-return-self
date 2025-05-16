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
GameSetup class >> newGameWithDie: aSetOfDie WithWormhole: wormhole [

	| gameSetupObject |
	gameSetupObject := self new.
	^ gameSetupObject initializeGameSetupWithDie: aSetOfDie WithWormhole: wormhole
]

{ #category : 'initialization' }
GameSetup >> initializeGameSetupWithDie: aSetOfDie WithWormhole: wormhole [

	| firstPlayer secondPlayer aSetOfPlayers aBoard aGame|
	firstPlayer := Player named: 'Juan'.
	secondPlayer := Player named: 'Tomi'.
	aSetOfPlayers := {
		                 firstPlayer.
		                 secondPlayer }.
	aBoard := Board withLenght: 20 and: wormhole.

	aGame := Game playedBy: aSetOfPlayers onBoard: aBoard withSetOfDie: aSetOfDie .
	
	^aGame.
]
