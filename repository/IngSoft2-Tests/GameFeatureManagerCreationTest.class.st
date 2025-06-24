Class {
	#name : 'GameFeatureManagerCreationTest',
	#superclass : 'GameplayFullInteractionTestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
GameFeatureManagerCreationTest >> test01WhenTryingToCreateAGameWithNegativeLapsThenItRaisesError [

	| aLoadedDie aTestBoard |
	aTestBoard := BoardForTesting createWith: aTileListCreator tileList.
	aLoadedDie := LoadedDie rolling: 4.
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
GameFeatureManagerCreationTest >> test01WhenTryingToCreateAnyGameFeatureWithTwoPlayersSharingIDThenItRaisesError [

	| anotherGroupOfPlayers aLoadedDie aTestBoard |
	aTestBoard := BoardForTesting createWith: aTileListCreator tileList.
	aLoadedDie := LoadedDie rolling: 4.
	anotherGroupOfPlayers := {
		                   (ShipPlayerAssociation
			                    createWith: 12
			                    and: 'Pedro').
		                   (ShipPlayerAssociation createWith: 12 and: 'Juan') }.
	self
		should: [
			Game
				playedBy: anotherGroupOfPlayers
				withBoard: aTestBoard
				withSetOfDie: aLoadedDie
				withLaps: 1 ]
		raiseErrorWithMessageText:
		'You cant have different players with the same ID.'.

	self
		should: [
		PositionManager twoPlayersCantHaveTheSameId: anotherGroupOfPlayers ]
		raiseErrorWithMessageText:
		'You cant have different players with the same ID.'.

	self
		should: [
		BattleManager twoPlayersCantHaveTheSameId: anotherGroupOfPlayers ]
		raiseErrorWithMessageText:
		'You cant have different players with the same ID.'.

	self
		should: [ TurnManager twoPlayersCantHaveTheSameId: anotherGroupOfPlayers ]
		raiseErrorWithMessageText:
		'You cant have different players with the same ID.'
]

{ #category : 'tests' }
GameFeatureManagerCreationTest >> test02WhenTryingToCreateAGameWithDiceThenItRaisesError [

	| aTestBoard |
	aTestBoard := BoardForTesting createWith: aTileListCreator tileList.
	self
		should: [
			Game
				playedBy: aGroupOfPlayers
				withBoard: aTestBoard
				withSetOfDie: {  }
				withLaps: 10 ]
		raiseErrorWithMessageText: 'You must have at least one die to play.'
]

{ #category : 'tests' }
GameFeatureManagerCreationTest >> test02WhenTryingToCreateAnyGameFeatureWithoutPlayersThenItRaisesError [

	| aLoadedDie aTestBoard |
	aTestBoard := BoardForTesting createWith: aTileListCreator tileList.
	aLoadedDie := LoadedDie rolling: 4.
	self
		should: [
			Game
				playedBy: {  }
				withBoard: aTestBoard
				withSetOfDie: aLoadedDie
				withLaps: 1 ]
		raiseErrorWithMessageText:
		'You cant play with less than two players.'.

	self
		should: [ PositionManager mustHaveAtLeastTwoPlayers: {  } ]
		raiseErrorWithMessageText:
		'You cant play with less than two players.'.

	self
		should: [ BattleManager mustHaveAtLeastTwoPlayers: {  } ]
		raiseErrorWithMessageText:
		'You cant play with less than two players.'.

	self
		should: [ TurnManager mustHaveAtLeastTwoPlayers: {  } ]
		raiseErrorWithMessageText:
		'You cant play with less than two players.'
]

{ #category : 'tests' }
GameFeatureManagerCreationTest >> test03WhenTryingToCreateAnyGameFeatureWithOnePlayersThenItRaisesError [

	| aLoadedDie aTestBoard |
	aTestBoard := BoardForTesting createWith: aTileListCreator tileList.
	aLoadedDie := LoadedDie rolling: 4.
	self
		should: [
			Game
				playedBy: aPlayer
				withBoard: aTestBoard
				withSetOfDie: aLoadedDie
				withLaps: 1 ]
		raiseErrorWithMessageText:
		'You cant play with less than two players.'.

	self
		should: [
			PositionManager mustHaveAtLeastTwoPlayers:
				aPlayer asOrderedCollection ]
		raiseErrorWithMessageText:
		'You cant play with less than two players.'.

	self
		should: [
			BattleManager mustHaveAtLeastTwoPlayers:
				aPlayer asOrderedCollection ]
		raiseErrorWithMessageText:
		'You cant play with less than two players.'.

	self
		should: [
		TurnManager mustHaveAtLeastTwoPlayers: aPlayer asOrderedCollection ]
		raiseErrorWithMessageText:
		'You cant play with less than two players.'
]
