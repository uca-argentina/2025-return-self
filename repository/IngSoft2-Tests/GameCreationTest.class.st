Class {
	#name : 'GameCreationTest',
	#superclass : 'InstanceCreationTest',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
GameCreationTest >> testWhenTryingToCreateAGameWithTwoPlayersSharingIDThenItRaisesError [

	| anotherGroupOfPlayers aLoadedDie aTestBoard |
	aTestBoard := BoardForTesting createWithTiles: 20 andEffects: {  }.
	aLoadedDie := LoadedDie rolling: 4.
	anotherGroupOfPlayers := {
		                         (ShipPlayerAssociation createWith: 12 and: 'Pedro').
		                         (ShipPlayerAssociation createWith: 12 and: 'Juan') }.
	self
		should: [
			Game
				playedBy: anotherGroupOfPlayers
				withBoard: aTestBoard
				withSetOfDie: aLoadedDie
				withLaps: 1 ]
		raiseErrorWithMessageText:
		'You cant have different players with the same ID.'
]
