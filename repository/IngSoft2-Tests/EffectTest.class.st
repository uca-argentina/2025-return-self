Class {
	#name : 'EffectTest',
	#superclass : 'GameplayFullInteractionTestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
EffectTest >> test01WhenWeCreateAWormholeWithAtLeastOneEndLessThanOneThenItRaisesAnError [

	self
		should: [ Wormhole createWith: -10 ]
		raiseErrorWithMessageText:
		'Both ends of the Wormhole must be greater than 1.'.
]

{ #category : 'tests' }
EffectTest >> testGamePlayedWithABlackHoleTile [

	| aGame aLoadedDie aBlackHoleTile aSecondLoadedDie aSequence aTestBoard |
	aBlackHoleTile := BlackHole create.
	
	aTileListCreator at: 4 put: aBlackHoleTile.
	aTestBoard := Board createWith: aTileListCreator tileList.
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
EffectTest >> testGamePlayedWithACardGiverTile [

	| aGame aCardGiverTile aSequence aTestBoard shipCards shipCardsOfJuan shipCardsOfTomi |
	aCardGiverTile := LoadedCardGiver createWith:
		                  (OrderedCollection with: Speed with: Acceleration).

	aTileListCreator at: 4 put: aCardGiverTile.
	aTestBoard := Board createWith: aTileListCreator tileList.
	aSequence := SequenceOfDieForTesting withDie:
		             { (LoadedDie rolling: 3) }.
	aGame := Game
		         playedBy: aGroupOfPlayers
		         withBoard: aTestBoard
		         withSetOfDie: aSequence
		         withLaps: 1.

	aGame playFullGame."por alguna razon se traba despues del primer tiro"

	shipCardsOfJuan := aGame cardsFeatureOf: (aGroupOfPlayers at: 1).


	shipCardsOfTomi := aGame cardsFeatureOf: (aGroupOfPlayers at: 2).

	self assert: (shipCardsOfJuan deck at: 3) isSpeed equals: true.
	self assert: (shipCardsOfTomi deck at: 3) isAcceleration equals: true
]

{ #category : 'tests' }
EffectTest >> testGamePlayedWithAHyperJumpTile [

	| hyperJumpEffect aTestBoard aSequenceOfRolls aGame assertingVariableData |
	assertingVariableData := { 'Name: Juan, Position: 5, Lap: 0'.
	                         'Name: Tomi, Position: 4, Lap: 0' }.
	hyperJumpEffect := HyperJump create.
	aTileListCreator at: 3 put: hyperJumpEffect.
	aTestBoard := BoardForTesting createWith: aTileListCreator tileList.
	aSequenceOfRolls := SequenceOfDieForTesting withDie: {
			                    (LoadedDie rolling: 2).
			                    (LoadedDie rolling: 2) }.
	aGame := Game
		         playedBy: aGroupOfPlayers
		         withBoard: aTestBoard
		         withSetOfDie: aSequenceOfRolls
		         withLaps: 1.

	self play: 2 in: aGame.

	self assert: aGame playerPositions equals: assertingVariableData
]

{ #category : 'tests' }
EffectTest >> testGamePlayedWithAHyperJumpTileChangingLap [

	| hyperJumpEffect aTestBoard aSequenceOfRolls aGame assertingVariableData |
	assertingVariableData := { 'Name: Juan, Position: 1, Lap: 1'.
	                         'Name: Tomi, Position: 4, Lap: 0' }.
	hyperJumpEffect := HyperJump create.
	aTileListCreator := TileListCreationForTesting createTileListWith: 4.
	aTileListCreator at: 3 put: hyperJumpEffect.
	aTestBoard := BoardForTesting createWith: aTileListCreator tileList.
	aSequenceOfRolls := SequenceOfDieForTesting withDie: {
			                    (LoadedDie rolling: 2).
			                    (LoadedDie rolling: 2) }.
	aGame := Game
		         playedBy: aGroupOfPlayers
		         withBoard: aTestBoard
		         withSetOfDie: aSequenceOfRolls
		         withLaps: 2.

	self play: 2 in: aGame.

	self assert: aGame playerPositions equals: assertingVariableData
]

{ #category : 'tests' }
EffectTest >> testGamePlayedWithAHyperSpaceJumpTile [

	| aGame aHyperSpaceJumpEffect aTestBoard aSequenceOfRolls assertingVariableData |
	assertingVariableData := { 'Name: Juan, Position: 5, Lap: 0'.
	                         'Name: Tomi, Position: 8, Lap: 0' }.
	aHyperSpaceJumpEffect := HyperSpaceJump create.
	aTileListCreator at: 4 put: aHyperSpaceJumpEffect.
	aTestBoard := BoardForTesting createWith: aTileListCreator tileList.

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

	| aGame aLoadedDie aMoonWalkEffect aSecondLoadedDie aSequence aTestBoard |
	aMoonWalkEffect := MoonWalk createEspeciallyWith: 11.
	aTileListCreator := TileListCreationForTesting createTileListWith: 24.
	aTileListCreator at: 4 put: aMoonWalkEffect.
	aTestBoard := BoardForTesting createWith: aTileListCreator tileList.
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

	| aGame aSequence aTestBoard |
	aTestBoard := BoardForTesting createWith: aTileListCreator tileList.

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

	| aGame aWormhole aTestBoard aSequenceOfRolls assertingVariable |
	assertingVariable := { 'Name: Juan, Position: 19, Lap: 0'.
	                     'Name: Tomi, Position: 1, Lap: 0' }.
	aWormhole := Wormhole createWith: 19.
	aTileListCreator at: 3 put: aWormhole.
	aTestBoard := BoardForTesting createWith: aTileListCreator tileList.
	aSequenceOfRolls := SequenceOfDieForTesting withDie:
		                    { (LoadedDie rolling: 2) }.
	aGame := Game
		         playedBy: aGroupOfPlayers
		         withBoard: aTestBoard
		         withSetOfDie: aSequenceOfRolls
		         withLaps: 1.
	aGame nextPlayerThrowsDice.
	self assert: aGame playerPositions equals: assertingVariable
]

{ #category : 'tests' }
EffectTest >> testGamePlayedWithAWormholeTileGoingBackwards [

	| aGame aWormhole aTestBoard aSequenceOfRolls assertingVariable |
	assertingVariable := { 'Name: Juan, Position: 2, Lap: 0'.
	                     'Name: Tomi, Position: 1, Lap: 0' }.
	aWormhole := Wormhole createWith: 2.
	aTileListCreator at: 8 put: aWormhole.
	aTestBoard := BoardForTesting createWith: aTileListCreator tileList.
	aSequenceOfRolls := SequenceOfDieForTesting withDie:
		                    { (LoadedDie rolling: 7) }.
	aGame := Game
		         playedBy: aGroupOfPlayers
		         withBoard: aTestBoard
		         withSetOfDie: aSequenceOfRolls
		         withLaps: 1.
	aGame nextPlayerThrowsDice.
	self assert: aGame playerPositions equals: assertingVariable
]

{ #category : 'tests' }
EffectTest >> testGamePlayedWithAllEffectsInAParticularTile [

	| aGame aSequence aTestBoard aMoonWalkTile aHSJTile aBlackHoleTile |
	aHSJTile := HyperSpaceJump create.
	aMoonWalkTile := MoonWalk createEspeciallyWith: 11.
	aBlackHoleTile := BlackHole create.
	aTileListCreator at: 4 put: aHSJTile.
	aTileListCreator at: 15 put: aMoonWalkTile.
	aTileListCreator at: 2 put: aBlackHoleTile.
	aTestBoard := BoardForTesting createWith: aTileListCreator tileList.

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
	anAtomikBombEffect := AtomikBomb create.
	aTileListCreator := TileListCreationForTesting createTileListWith: 24.
	aTileListCreator at: 7 put: anAtomikBombEffect.
	aTestBoard := BoardForTesting createWith: aTileListCreator tileList.
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
