Class {
	#name : 'PositionManagerTest',
	#superclass : 'ReturnSelfTestCase',
	#instVars : [
		'aPlayer',
		'aPositionManager',
		'anotherPlayer'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'running' }
PositionManagerTest >> setUp [

	| aGroupOfPlayers aBoardLength aNumberOfLaps |
	super setUp.
	aBoardLength := 10.
	aNumberOfLaps := 3.
	aPlayer := ShipPlayerAssociation createWith: 1 and: 'Juan'.
	anotherPlayer := ShipPlayerAssociation createWith: 2 and: 'Tomi'.
	aGroupOfPlayers := {
		                   aPlayer.
		                   anotherPlayer }.

	aPositionManager := PositionManager createWith: aGroupOfPlayers and: 10 and: 3
]

{ #category : 'tests' }
PositionManagerTest >> test01PositionManagerCanTellItsShipsToMoveForwardADistance [

	| aShipStatus |
	aPositionManager move: aPlayer forwardWith: 5.
	aShipStatus := aPositionManager findShipReference: aPlayer.

	self assert: aShipStatus position equals: 6
]

{ #category : 'tests' }
PositionManagerTest >> test02PositionManagerCanTellItsShipsToMoveBackwardsADistance [

	| aShipStatus |
	aPositionManager move: aPlayer forwardWith: 5.
	aPositionManager move: aPlayer backwardWith: 2.
	aShipStatus := aPositionManager findShipReference: aPlayer.

	self assert: aShipStatus position equals: 4
]

{ #category : 'tests' }
PositionManagerTest >> test03WhenAPlayerIsInFirstTileThenManagerTellsCantBattle [

	self deny: (aPositionManager checkIfBattle: aPlayer).
]

{ #category : 'tests' }
PositionManagerTest >> test04ManagerKnowsIfAShipSurpassesTheBoardLengthAndReturnsANewShipWithIncreasedLap [

	| aShipPosition aNewShipPosition |
	aShipPosition := ShipPosition createWith: 3 and: 15 and: 2.
	aNewShipPosition := aPositionManager checkIfReachedANewLap:
		                    aShipPosition.

	self assert: aNewShipPosition position equals: 5.
	self assert: aNewShipPosition lap equals: 3.
	self deny: aShipPosition lap equals: 3
]

{ #category : 'tests' }
PositionManagerTest >> test05WhenAShipSurpassesBoardLengthThenManagerReturnsANewShipWithTheNewLapAndCorrectPosition [

	| aShipPosition |
	
	aPositionManager move: aPlayer forwardWith: 15.
	aShipPosition := aPositionManager findShipReference: aPlayer.

	self assert: aShipPosition position equals: 6.
	self assert: aShipPosition lap equals: 1.
]

{ #category : 'tests' }
PositionManagerTest >> test06WhenTheManagerIsAskedWhichPlayersAreInSamePositionThanOneThenItReturnsAnArrayWithAllThePlayersInThatPosition [

	aPositionManager move: aPlayer forwardWith: 5.
	aPositionManager move: anotherPlayer forwardWith: 5.

	self
		assert: (aPositionManager playerInSamePositionThan: aPlayer) size
		equals: 2
]

{ #category : 'tests' }
PositionManagerTest >> test07WhenTheManagerResetsLapToAShipThenThisOneGoesBackToTile1SameLap [

	| aShipPosition aNewShipPosition |
	aPositionManager move: aPlayer forwardWith: 5.
	aShipPosition := aPositionManager findShipReference: aPlayer.

	aPositionManager resetLapTo: aPlayer.
	aNewShipPosition := aPositionManager findShipReference: aPlayer.

	self assert: aNewShipPosition position equals: 1.
	self deny: aShipPosition position equals: 1
]

{ #category : 'tests' }
PositionManagerTest >> test08WhenNoShipReachedTheAmountOfLapsToWinThenTheGameIsStillBeingPlayed [

	aPositionManager move: aPlayer forwardWith: 5.

	self assert: aPositionManager stillPlaying
]

{ #category : 'tests' }
PositionManagerTest >> test09WhenAShipReachedTheAmountOfLapsToWinThenTheGameIsFinished [

	aPositionManager move: aPlayer forwardWith: 10.
	aPositionManager move: aPlayer forwardWith: 10.
	aPositionManager move: aPlayer forwardWith: 10.

	self deny: aPositionManager stillPlaying
]

{ #category : 'tests' }
PositionManagerTest >> test10WhenAShipReachedTheAmountOfLapsToWinThenManagerCanReturnTheWinner [

	aPositionManager move: aPlayer forwardWith: 10.
	aPositionManager move: aPlayer forwardWith: 10.
	aPositionManager move: aPlayer forwardWith: 10.

	self assert: aPositionManager winner id equals: aPlayer id.
	self deny: aPositionManager winner id equals: anotherPlayer id
]

{ #category : 'tests' }
PositionManagerTest >> test11WhenNoShipReachedTheAmountOfLapsToWinThenManagerCantReturnAWinner [

	aPositionManager move: aPlayer forwardWith: 5.

	self
		should: [ aPositionManager winner ]
		raiseErrorWithMessageText: 'There is no winner yet.'
]

{ #category : 'tests' }
PositionManagerTest >> test12PositionManagerCanReturn2DArrayWithShipPositionAndAStringContainingThePositionInfoOfEveryShipInGame [

	| assertingVariableData |

	aPositionManager move: aPlayer forwardWith: 5.
	
	assertingVariableData := {
		                         {
			                         (aPositionManager findShipReference:
				                          aPlayer).
			                         'Position: 6, Lap: 0' }.
		                         {
			                         (aPositionManager findShipReference:
				                          anotherPlayer).
			                         'Position: 1, Lap: 0' } }.

	self
		assert: aPositionManager playerPositions
		equals: assertingVariableData
]

{ #category : 'tests' }
PositionManagerTest >> test13WhenTwoPlayersAreNotInFirstTileAndInASameTileThenManagerTellsTheyCanBattle [

	aPositionManager move: aPlayer forwardWith: 5.
	aPositionManager move: anotherPlayer forwardWith: 5.
	
	self assert: (aPositionManager checkIfBattle: aPlayer).
]

{ #category : 'tests' }
PositionManagerTest >> test14PositionManagerCanReturn2DArrayWithIdAndAStringContainingThePlaceRankingOfShips [

	| assertingVariableData |
	assertingVariableData := {
		                         { 2. 'Place: 1' }.
		                         { 1. 'Place: 2' } }.

	aPositionManager move: anotherPlayer forwardWith: 5.

	self
		assert: aPositionManager playerRanking
		equals: assertingVariableData
]
