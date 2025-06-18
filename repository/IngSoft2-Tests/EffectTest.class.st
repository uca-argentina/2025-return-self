Class {
	#name : 'EffectTest',
	#superclass : 'ReturnSelfTestCase',
	#instVars : [
		'aGroupOfPlayers'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'running' }
EffectTest >> setUp [

	super setUp.
	aGroupOfPlayers := {
		                   (ShipPlayerAssociation createWith: 1 and: 'Juan').
		                   (ShipPlayerAssociation createWith: 2 and: 'Tomi') }
]

{ #category : 'tests' }
EffectTest >> testGamePlayedWithABlackHoleTile [
	| aGame aLoadedDie aBlackHoleTile aSecondLoadedDie aSequence aTestBoard|
	aBlackHoleTile := BlackHole createOnTile: 4.
	aTestBoard := BoardForTesting createWithTiles: 20 andEffects: { aBlackHoleTile }.
	aLoadedDie := LoadedDie rolling: 2.
	aSecondLoadedDie := LoadedDie rolling: 3.
	aSequence := SequenceOfDieForTesting 
		             withDie: {
				             aLoadedDie.
				             aSecondLoadedDie }.
	aGame := Game
		         playedBy: aGroupOfPlayers
		         withBoard: aTestBoard 
		         withSetOfDie: aSequence
					withLaps: 1.
					
	aGame playFullGame.

	self assert: (aGame isWinner: 'Juan') "gana juan porque tomi se queda en un loop hasta que gane juan a proposito"

]

{ #category : 'tests' }
EffectTest >> testGamePlayedWithAHyperJumpTile [

	| hyperJumpEffect aTestBoard aSequenceOfRolls aGame assertingVariableData |
	assertingVariableData := { 'Name: Juan, Position: 7, Lap: 0'.
	                         'Name: Tomi, Position: 8, Lap: 0' }.
	hyperJumpEffect := HyperJump createOnTile: 3.
	aTestBoard := BoardForTesting
		              createWithTiles: 20
		              andEffects: (Array with: hyperJumpEffect).
	aSequenceOfRolls := SequenceOfDieForTesting withDie: {
			                    (LoadedDie rolling: 1).
			                    (LoadedDie rolling: 2) }.
	aGame := Game
		         playedBy: aGroupOfPlayers
		         withBoard: aTestBoard
		         withSetOfDie: aSequenceOfRolls
		         withLaps: 1.

	self play: 3 in: aGame.

	self assert: aGame playerPositions equals: assertingVariableData
]

{ #category : 'tests' }
EffectTest >> testGamePlayedWithAHyperSpaceJumpTile [

	| aGame aHyperSpaceJumpEffect aTestBoard aSequenceOfRolls assertingVariableData |
	assertingVariableData := { 'Name: Juan, Position: 5, Lap: 0'.
	                         'Name: Tomi, Position: 8, Lap: 0' }.
	aHyperSpaceJumpEffect := HyperSpaceJump createOnTile: 4.
	aTestBoard := BoardForTesting
		              createWithTiles: 20
		              andEffects: (Array with: aHyperSpaceJumpEffect).

	aSequenceOfRolls := SequenceOfDieForTesting withDie: {
			                    (LoadedDie rolling: 4).
			                    (LoadedDie rolling: 3) }.
	aGame := Game
		         playedBy: aGroupOfPlayers
		         withBoard: aTestBoard
		         withSetOfDie: aSequenceOfRolls
		         withLaps: 1.

	self play: 2 in: aGame.

	self assert: aGame playerPositions equals: assertingVariableData
]

{ #category : 'tests' }
EffectTest >> testGamePlayedWithAMoonWalkTile [
	| aGame aLoadedDie aMoonWalkTile aSecondLoadedDie aSequence aTestBoard|
	aMoonWalkTile := MoonWalk createOnTile: 15 withDebuff: 11.
	aTestBoard:= BoardForTesting createWithTiles: 24 andEffects: (Array with: aMoonWalkTile ).
	aLoadedDie := LoadedDie rolling: 7. 	     
	aSecondLoadedDie := LoadedDie rolling: 8. 
	aSequence := SequenceOfDieForTesting 
		             withDie: {
				             aLoadedDie.
				             aSecondLoadedDie }.
	aGame := Game
		         playedBy: aGroupOfPlayers
		         withBoard: aTestBoard 
		         withSetOfDie: aSequence
					withLaps: 1.
					
	aGame playFullGame.

	self assert: (aGame isWinner: 'Juan') 
]

{ #category : 'tests' }
EffectTest >> testGamePlayedWithANoEffectTile [

	| aGame aNoEffectTile aSequence aTestBoard |
	aNoEffectTile := NoEffect new.
	aTestBoard := BoardForTesting
		              createWithTiles: 20
		              andEffects: (Array with: aNoEffectTile).

	aSequence := SequenceOfDieForTesting withDie: {
			             (LoadedDie rolling: 4).
			             (LoadedDie rolling: 1) }.
	aGame := Game
		         playedBy: aGroupOfPlayers
		         withBoard: aTestBoard
		         withSetOfDie: aSequence
		         withLaps: 1.

	aGame playFullGame.

	self assert: (aGame isWinner: 'Juan')
]

{ #category : 'tests' }
EffectTest >> testGamePlayedWithAWormholeTile [

	| tmp1 tmp2 tmp3 tmp4 tmp5 |
	tmp3 := Wormhole oneEnd: 3 otherEnd: 19.
	tmp5 := BoardForTesting
		        createWithTiles: 20
		        andEffects: (Array with: tmp3).
	tmp2 := LoadedDie rolling: 2.
	tmp4 := SequenceOfDieForTesting withDie: { tmp2 }.
	tmp1 := Game
		        playedBy: aGroupOfPlayers
		        withBoard: tmp5
		        withSetOfDie: tmp4
		        withLaps: 1.
	tmp1 nextPlayerThrowsDice.
	self
		assert: tmp1 playerPositions
		equals: { 'Juan : 19 , lap: 0'. 'Tomi : 1 , lap: 0' }
]

{ #category : 'tests' }
EffectTest >> testGamePlayedWithAllEffectsInAParticularTile [

	| aGame aSequence aTestBoard aMoonWalkTile aHSJTile aBlackHoleTile |
	aHSJTile := HyperSpaceJump createOnTile: 4.
	aMoonWalkTile := MoonWalk createOnTile: 15 withDebuff: 11.
	aBlackHoleTile := BlackHole createOnTile: 2.
	aTestBoard := BoardForTesting createWithTiles: 20 andEffects: {
			              aHSJTile.
			              aMoonWalkTile.
			              aBlackHoleTile }.

	aSequence := SequenceOfDieForTesting withDie: {
			             (LoadedDie rolling: 7).
			             (LoadedDie rolling: 8) }.
	aGame := Game
		         playedBy: aGroupOfPlayers
		         withBoard: aTestBoard
		         withSetOfDie: aSequence
		         withLaps: 1.

	aGame playFullGame.

	self assert: (aGame isWinner: 'Juan')
]

{ #category : 'tests' }
EffectTest >> testGamePlayedWithAnAtomikBombTile [

	| aGame anAtomikBombEffect aSequenceOfRolls aTestBoard assertingVariableData1 assertingVariableData2 |
	assertingVariableData1 := { 'Name: Juan, Position: 4, Lap: 0'.
	                          'Name: Tomi, Position: 5, Lap: 0' }.
	assertingVariableData2 := { 'Name: Juan, Position: 1, Lap: 0'.
	                          'Name: Tomi, Position: 1, Lap: 0' }.
	anAtomikBombEffect := AtomikBomb createOnTile: 7.
	aTestBoard := BoardForTesting
		              createWithTiles: 24
		              andEffects: { anAtomikBombEffect }.
	aSequenceOfRolls := SequenceOfDieForTesting withDie: {
			                    (LoadedDie rolling: 3).
			                    (LoadedDie rolling: 4).
			                    (LoadedDie rolling: 3).
			                    (LoadedDie rolling: 2) }.
	aGame := Game
		         playedBy: aGroupOfPlayers
		         withBoard: aTestBoard
		         withSetOfDie: aSequenceOfRolls
		         withLaps: 1.

	self play: 2 in: aGame.

	self assert: aGame playerPositions equals: assertingVariableData1.

	self play: 1 in: aGame.

	self assert: aGame playerPositions equals: assertingVariableData2
]
