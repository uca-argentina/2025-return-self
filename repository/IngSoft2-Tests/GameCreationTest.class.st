Class {
	#name : 'GameCreationTest',
	#superclass : 'ReturnSelfTestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
GameCreationTest >> test01WhenTryingToCreateAGameWithNegativeLapsThenItRaisesError [

	| aGroupOfPlayers aLoadedDie aTestBoard aTileList |
	aTileList := self createTileListWith: 20.
	aTestBoard := BoardForTesting createWith: aTileList.
	aLoadedDie := LoadedDie rolling: 4.
	aGroupOfPlayers := {
		                   (ShipPlayerAssociation
			                    createWith: 1
			                    and: 'Pedro').
		                   (ShipPlayerAssociation createWith: 2 and: 'Juan') }.
	self
		should: [
			Game
				playedBy: aGroupOfPlayers
				withBoard: aTestBoard
				withSetOfDie: aLoadedDie
				withLaps: -10 ]
		raiseErrorWithMessageText:
		'The amount of laps cannot be lower than 1.'
]

{ #category : 'tests' }
GameCreationTest >> test02WhenTryingToCreateAGameWithDiceThenItRaisesError [

	| aGroupOfPlayers aLoadedDie aTestBoard aTileList |
	aTileList := self createTileListWith: 20.
	aTestBoard := BoardForTesting createWith: aTileList.
	aLoadedDie := LoadedDie rolling: 4.
	aGroupOfPlayers := {
		                   (ShipPlayerAssociation createWith: 1 and: 'Pedro').
		                   (ShipPlayerAssociation createWith: 2 and: 'Juan') }.
	self
		should: [
			Game
				playedBy: aGroupOfPlayers
				withBoard: aTestBoard
				withSetOfDie: {  }
				withLaps: 10 ]
		raiseErrorWithMessageText: 'You must have at least one die to play.'
]
