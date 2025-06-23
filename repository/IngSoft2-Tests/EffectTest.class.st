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

	| aGame aLoadedDie aBlackHoleTile aSecondLoadedDie aSequence aTestBoard aTileList |
	aBlackHoleTile := BlackHole create.
	aTileList := self createTileListWith: 20.
	aTileList at: 4 put: (Tile createWithEffect: aBlackHoleTile).
	aTestBoard := BoardForTesting createWith: aTileList.
	aLoadedDie := LoadedDie rolling: 2.
	aSecondLoadedDie := LoadedDie rolling: 3.
	aSequence := SequenceOfDieForTesting withDie: {
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

	| hyperJumpEffect aTestBoard aSequenceOfRolls aGame assertingVariableData aTileList |
	assertingVariableData := { 'Name: Juan, Position: 7, Lap: 0'.
	                         'Name: Tomi, Position: 8, Lap: 0' }.
	hyperJumpEffect := HyperJump create.
	aTileList := self createTileListWith: 20.
	aTileList at: 3 put: (Tile createWithEffect: hyperJumpEffect).
	aTestBoard := BoardForTesting createWith: aTileList.
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

	| aGame aHyperSpaceJumpEffect aTestBoard aSequenceOfRolls assertingVariableData aTileList |
	assertingVariableData := { 'Name: Juan, Position: 5, Lap: 0'.
	                         'Name: Tomi, Position: 8, Lap: 0' }.
	aHyperSpaceJumpEffect := HyperSpaceJump create.
	aTileList := self createTileListWith: 20.
	aTileList at: 4 put: (Tile createWithEffect: aHyperSpaceJumpEffect).
	aTestBoard := BoardForTesting createWith: aTileList.

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

	| aGame aLoadedDie aMoonWalkEffect aSecondLoadedDie aSequence aTestBoard aTileList |
	aMoonWalkEffect := MoonWalk createEspeciallyWith: 11.
	aTileList := self createTileListWith: 24.
	aTileList at: 4 put: (Tile createWithEffect: aMoonWalkEffect).
	aTestBoard := BoardForTesting createWith: aTileList.
	aLoadedDie := LoadedDie rolling: 7.
	aSecondLoadedDie := LoadedDie rolling: 8.
	aSequence := SequenceOfDieForTesting withDie: {
			             aLoadedDie.
			             aSecondLoadedDie }.
	aGame := Game
		         playedBy: aGroupOfPlayers
		         withBoard: aTestBoard
		         withSetOfDie: aSequence
		         withLaps: 1.

	aGame playFullGame.

	self assert: (aGame isWinner: 'Tomi')
]

{ #category : 'tests' }
EffectTest >> testGamePlayedWithANoEffectTile [

	| aGame aSequence aTestBoard aTileList |
	aTileList := self createTileListWith: 20.
	aTestBoard := BoardForTesting createWith: aTileList.

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

	| aGame aWormhole aTestBoard aSequenceOfRolls aTileList assertingVariable |
	assertingVariable := { 'Name: Juan, Position: 19, Lap: 0'. 'Name: Tomi, Position: 1, Lap: 0' }.
	aWormhole := Wormhole createWith: 19.
	aTileList := self createTileListWith: 20.
	aTileList at: 3 put: (Tile createWithEffect: aWormhole).
	aTestBoard := BoardForTesting createWith: aTileList.
	aSequenceOfRolls := SequenceOfDieForTesting withDie:
		                    { (LoadedDie rolling: 2) }.
	aGame := Game
		         playedBy: aGroupOfPlayers
		         withBoard: aTestBoard
		         withSetOfDie: aSequenceOfRolls
		         withLaps: 1.
	aGame nextPlayerThrowsDice.
	self
		assert: aGame playerPositions
		equals: assertingVariable
]

{ #category : 'tests' }
EffectTest >> testGamePlayedWithAllEffectsInAParticularTile [

	| aGame aSequence aTestBoard aMoonWalkTile aHSJTile aBlackHoleTile aTileList |
	aHSJTile := HyperSpaceJump create.
	aMoonWalkTile := MoonWalk createEspeciallyWith: 11.
	aBlackHoleTile := BlackHole create.
	aTileList := self createTileListWith: 20.
	aTileList at: 4 put: (Tile createWithEffect: aHSJTile).
	aTileList at: 15 put: (Tile createWithEffect: aMoonWalkTile).
	aTileList at: 2 put: (Tile createWithEffect: aBlackHoleTile).
	aTestBoard := BoardForTesting createWith: aTileList.

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

	| aGame anAtomikBombEffect aSequenceOfRolls aTestBoard assertingVariableData1 assertingVariableData2 aTileList |
	assertingVariableData1 := { 'Name: Juan, Position: 4, Lap: 0'.
	                          'Name: Tomi, Position: 5, Lap: 0' }.
	assertingVariableData2 := { 'Name: Juan, Position: 1, Lap: 0'.
	                          'Name: Tomi, Position: 1, Lap: 0' }.
	anAtomikBombEffect := AtomikBomb create.
	aTileList := self createTileListWith: 24.
	aTileList at: 7 put: (Tile createWithEffect: anAtomikBombEffect).
	aTestBoard := BoardForTesting createWith: aTileList.
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
