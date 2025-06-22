Class {
	#name : 'GameplayBattleMechanicTest',
	#superclass : 'ReturnSelfTestCase',
	#instVars : [
		'aGroupOfPlayers',
		'aPlayer'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'running' }
GameplayBattleMechanicTest >> setUp [

	super setUp.
	aPlayer := ShipPlayerAssociation createWith: 1 and: 'Juan'.
	aGroupOfPlayers := {
		                   aPlayer.
		                   (ShipPlayerAssociation createWith: 2 and: 'Tomi') }
]

{ #category : 'tests' }
GameplayBattleMechanicTest >> test01BattleSituation [

	| aGame aWormhole aSequenceOfRolls aTestBoard loadedDiceToMove loadedDiceToFight assertingVariableData |
	assertingVariableData := { 'Name: Juan, Position: 1, Lap: 0'.
	                         'Name: Tomi, Position: 3, Lap: 0' }.
	loadedDiceToMove := {
		                    (LoadedDie rolling: 2).
		                    (LoadedDie rolling: 2) }.
	loadedDiceToFight := {
		                     (LoadedDie rolling: 1).
		                     (LoadedDie rolling: 5) }.
	aSequenceOfRolls := SequenceOfDieForTesting withDie:
		                    loadedDiceToMove , loadedDiceToFight.
	aWormhole := Wormhole oneEnd: 4 otherEnd: 9.
	aTestBoard := BoardForTesting
		              createWithTiles: 10
		              andEffects: { aWormhole }.
	aGame := Game
		         playedBy: aGroupOfPlayers
		         withBoard: aTestBoard
		         withSetOfDie: aSequenceOfRolls
		         withLaps: 1.
	
	self play: 2 in: aGame.

	self assert: aGame playerPositions equals: assertingVariableData
]

{ #category : 'tests' }
GameplayBattleMechanicTest >> test02BattleSituationThenKeepPlaying [

	| aGame aWormhole dieThrowSequence aTestBoard loadedDiceToMove1 loadedDiceToMove2 loadedDiceToFight assertingVariableData1 assertingVariableData2 |
	loadedDiceToMove1 := {
		                     (LoadedDie rolling: 2).
		                     (LoadedDie rolling: 2) }.
	loadedDiceToMove2 := {
		                     (LoadedDie rolling: 3).
		                     (LoadedDie rolling: 4).
		                     (LoadedDie rolling: 7) }.
	loadedDiceToFight := {
		                     (LoadedDie rolling: 1).
		                     (LoadedDie rolling: 5) }.
	assertingVariableData1 := { 'Name: Juan, Position: 3, Lap: 0'.
	                          'Name: Tomi, Position: 1, Lap: 0' }.
	assertingVariableData2 := { 'Name: Juan, Position: 1, Lap: 0'.
	                          'Name: Tomi, Position: 3, Lap: 0' }.
	dieThrowSequence := SequenceOfDieForTesting withDie:
		                    loadedDiceToMove1 , loadedDiceToFight
		                    , loadedDiceToMove2.

	aWormhole := Wormhole oneEnd: 4 otherEnd: 9.
	aTestBoard := BoardForTesting
		              createWithTiles: 10
		              andEffects: { aWormhole }.
	aGame := Game
		         playedBy: aGroupOfPlayers
		         withBoard: aTestBoard
		         withSetOfDie: dieThrowSequence 
		         withLaps: 1.

	self play: 1 in: aGame.
	self assert: aGame playerPositions equals: assertingVariableData1.
	self play: 1 in: aGame.
	self assert: aGame playerPositions equals: assertingVariableData2.
	self play: 3 in: aGame.
	self assert: (aGame isWinner: 'Juan')
]

{ #category : 'tests' }
GameplayBattleMechanicTest >> test03RunningOutOfShieldsAndSkippingTwoTurns [

	| aGame aWormhole dieThrowSequence aTestBoard loadedDiceToMove1 loadedDiceToMove2 loadedDiceToMove3 loadedDiceToFight assertingVariableData1 assertingVariableData2 assertingVariableData3 |
	assertingVariableData1 := { 'Name: Juan, Position: 1, Lap: 0'.
	                          'Name: Tomi, Position: 4, Lap: 0' }.
	assertingVariableData2 := { 'Name: Juan, Position: 1, Lap: 0'.
	                          'Name: Tomi, Position: 6, Lap: 0' }.
	assertingVariableData3 := { 'Name: Juan, Position: 2, Lap: 0'.
	                          'Name: Tomi, Position: 6, Lap: 0' }.
	loadedDiceToMove1 := {
		                     (LoadedDie rolling: 1).
		                     (LoadedDie rolling: 1) }.
	loadedDiceToMove2 := {
		                     (LoadedDie rolling: 2).
		                     (LoadedDie rolling: 1) }.
	loadedDiceToMove3 := {
		                     (LoadedDie rolling: 3).
		                     (LoadedDie rolling: 1) }.
	loadedDiceToFight := {
		                     (LoadedDie rolling: 1).
		                     (LoadedDie rolling: 5) }.
	dieThrowSequence := SequenceOfDieForTesting withDie:
		                    loadedDiceToMove1 , loadedDiceToFight
		                    , loadedDiceToMove2 , loadedDiceToFight
		                    , loadedDiceToMove3 , loadedDiceToFight
		                    , loadedDiceToMove1 , loadedDiceToMove1
		                    , loadedDiceToMove1.

	aWormhole := Wormhole oneEnd: 8 otherEnd: 29.
	aTestBoard := BoardForTesting
		              createWithTiles: 30
		              andEffects: { aWormhole }.
	aGame := Game
		         playedBy: aGroupOfPlayers
		         withBoard: aTestBoard
		         withSetOfDie: dieThrowSequence 
		         withLaps: 1.

	self play: 6 in: aGame.

	self assert: aGame playerPositions equals: assertingVariableData1. "gana tomi - juan no tiene mas escudos"

	self play: 2 in: aGame.

	self assert: aGame playerPositions equals: assertingVariableData2. "juan se saltea este turno - tomi tira"

	self play: 1 in: aGame.

	self assert: aGame playerPositions equals: assertingVariableData3 "juan recupera los escudos - tira"
]

{ #category : 'tests' }
GameplayBattleMechanicTest >> test04SkippingTurnAndReplenishingShield [

	| aGame aLoadedDie aWormhole dieThrowSequence aTestBoard loadedDiceToMove1 loadedDiceToMove2 loadedDiceToMove3 loadedDiceToFight aShipShield aNewShipShield |
	loadedDiceToMove1 := {
		                     (LoadedDie rolling: 1).
		                     (LoadedDie rolling: 1) }.
	loadedDiceToMove2 := {
		                     (LoadedDie rolling: 2).
		                     (LoadedDie rolling: 1) }.
	loadedDiceToMove3 := {
		                     (LoadedDie rolling: 3).
		                     (LoadedDie rolling: 1) }.
	loadedDiceToFight := {
		                     (LoadedDie rolling: 1).
		                     (LoadedDie rolling: 5) }.
	dieThrowSequence := SequenceOfDieForTesting withDie:
		                    loadedDiceToMove1 , loadedDiceToFight
		                    , loadedDiceToMove2 , loadedDiceToFight
		                    , loadedDiceToMove3 , loadedDiceToFight
		                    , loadedDiceToMove1 , loadedDiceToMove1
		                    , loadedDiceToMove1.

	aWormhole := Wormhole oneEnd: 8 otherEnd: 29.
	aTestBoard := BoardForTesting
		              createWithTiles: 30
		              andEffects: { aWormhole }.
	aLoadedDie := dieThrowSequence.
	aGame := Game
		         playedBy: aGroupOfPlayers
		         withBoard: aTestBoard
		         withSetOfDie: aLoadedDie
		         withLaps: 1.

	self play: 2 in: aGame.
	
	aShipShield := aGame shieldsFeatureOf: aPlayer.
	
	self skip: 1 in: aGame.

	aNewShipShield := aGame shieldsFeatureOf: aPlayer.

	self assert: aShipShield shields equals: 2.
	self assert: aNewShipShield shields equals: 3
]
