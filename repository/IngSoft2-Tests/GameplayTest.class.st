Class {
	#name : 'GameplayTest',
	#superclass : 'GameplayFullInteractionTestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
GameplayTest >> test01WhenAGameIsPlayedWithASetOfDie [

	| aGame firstLoadedDice secondLoadedDice aWormhole aSetOfDie aTestBoard |
	aWormhole := Wormhole createWith: 14.
	aTileListCreator at: 5 put: aWormhole.
	aTestBoard := Board createWith: aTileListCreator tileList.
	firstLoadedDice := LoadedDie rolling: 3.
	secondLoadedDice := LoadedDie rolling: 5.
	aSetOfDie := DieSet having: {
			             firstLoadedDice.
			             secondLoadedDice }.
	aGame := Game
		         playedBy: aGroupOfPlayers
		         withBoard: aTestBoard
		         withSetOfDie: aSetOfDie
		         withLaps: 1.

	self play: 1 in: aGame.
	self assert: (aGame positionFeatureOf: aPlayer) position equals: 9
]

{ #category : 'tests' }
GameplayTest >> test02WhenAGameStartsTheresTheFirstTurn [

	| aGame aLoadedDie aWormhole aTestBoard |
	aWormhole := Wormhole createWith: 14.
	aTileListCreator at: 3 put: aWormhole.
	aTestBoard := Board createWith: aTileListCreator tileList.
	aLoadedDie := LoadedDie rolling: 4.
	aGame := Game
		         playedBy: aGroupOfPlayers
		         withBoard: aTestBoard
		         withSetOfDie: aLoadedDie
		         withLaps: 1.

	self play: 1 in: aGame.

	self assert: (aGame positionFeatureOf: aPlayer) position equals: 5
]

{ #category : 'tests' }
GameplayTest >> test03WhenTheGameIsAtTheSecondTurn [

	| aGame aWormhole aTestBoard aSequenceOfRolls |
	aWormhole := Wormhole createWith: 14.

	aTileListCreator at: 3 put: aWormhole.
	aTestBoard := Board createWith: aTileListCreator tileList.
	aSequenceOfRolls := SequenceOfDieForTesting withDie: {
			                    (LoadedDie rolling: 2).
			                    (LoadedDie rolling: 1).
			                    (LoadedDie rolling: 2) }.
	aGame := Game
		         playedBy: aGroupOfPlayers
		         withBoard: aTestBoard
		         withSetOfDie: aSequenceOfRolls
		         withLaps: 1.

	self play: 3 in: aGame.

	self assert: (aGame positionFeatureOf: aPlayer) position equals: 16
]

{ #category : 'tests' }
GameplayTest >> test04WhenTheGamePlaysItselfThenThereIsAWinner [

	| aGame aWormhole aTestBoard aSequenceOfRolls |
	aWormhole := Wormhole createWith: 14.
	aTileListCreator at: 3 put: aWormhole.
	aTestBoard := Board createWith: aTileListCreator tileList.
	aSequenceOfRolls := SequenceOfDieForTesting withDie: {
			                    (LoadedDie rolling: 2).
			                    (LoadedDie rolling: 1).
			                    (LoadedDie rolling: 2) }.
	aGame := Game
		         playedBy: aGroupOfPlayers
		         withBoard: aTestBoard
		         withSetOfDie: aSequenceOfRolls
		         withLaps: 1.

	aGame playFullGame.

	self assert: (aGame isWinner: 'Juan')
]

{ #category : 'tests' }
GameplayTest >> test05WhenSteppingIntoWormhole [

	| aGame aWormhole aTestBoard aSequenceOfRolls anotherPlayer |
	anotherPlayer := ShipPlayerAssociation createWith: 2 and: 'Tomi'.
	aWormhole := Wormhole createWith: 14.
	aTileListCreator at: 5 put: aWormhole.
	aTestBoard := Board createWith: aTileListCreator tileList.
	aSequenceOfRolls := SequenceOfDieForTesting withDie: {
			                    (LoadedDie rolling: 2).
			                    (LoadedDie rolling: 1).
			                    (LoadedDie rolling: 2) }.
	aGame := Game
		         playedBy: aGroupOfPlayers
		         withBoard: aTestBoard
		         withSetOfDie: aSequenceOfRolls
		         withLaps: 1.


	self play: 2 in: aGame.
	"Steps on wormhole here, on next turn it goes through. VAMOS A TENER QUE CORREGIR ESTO"
	self
		assert: (aGame positionFeatureOf: anotherPlayer) position
		equals: 2
]

{ #category : 'tests' }
GameplayTest >> test06WhenThereIsATurnAfterGameIsFinishedTHenItReturnsTheWinner [

	| aGame aWormhole aTestBoard aSequenceOfRolls |
	aWormhole := Wormhole createWith: 14.
	aTileListCreator at: 3 put: aWormhole.
	aTestBoard := Board createWith: aTileListCreator tileList.
	aSequenceOfRolls := SequenceOfDieForTesting withDie: {
			                    (LoadedDie rolling: 2).
			                    (LoadedDie rolling: 1).
			                    (LoadedDie rolling: 2) }.
	aGame := Game
		         playedBy: aGroupOfPlayers
		         withBoard: aTestBoard
		         withSetOfDie: aSequenceOfRolls
		         withLaps: 1.

	aGame playFullGame.
	self assert: (aGame isWinner: 'Juan')
]

{ #category : 'tests' }
GameplayTest >> test07GamePlayedWithASingleLapNoBattles [

	| aGame aWormhole aTestBoard aSequenceOfRolls |
	aWormhole := Wormhole createWith: 14.
	aTileListCreator at: 3 put: aWormhole.
	aTestBoard := Board createWith: aTileListCreator tileList.
	aSequenceOfRolls := SequenceOfDieForTesting withDie: {
			                    (LoadedDie rolling: 2).
			                    (LoadedDie rolling: 1).
			                    (LoadedDie rolling: 2) }.
	aGame := Game
		         playedBy: aGroupOfPlayers
		         withBoard: aTestBoard
		         withSetOfDie: aSequenceOfRolls
		         withLaps: 1.

	aGame playFullGame.

	self assert: (aGame isWinner: 'Juan')
]

{ #category : 'tests' }
GameplayTest >> test08LoopingOfTheLap [

	| aGame aWormhole aTestBoard aSequenceOfRolls assertingVariableData aTileListCreator2 |
	assertingVariableData := { 'Name: Juan, Position: 2, Lap: 1'.
	                         'Name: Tomi, Position: 1, Lap: 0' }.
	aWormhole := Wormhole createWith: 4.
	aTileListCreator2 := TileListCreationForTesting createTileListWith: 5.
	aTileListCreator2 at: 3 put: aWormhole.
	aTestBoard := Board createWith: aTileListCreator2 tileList.
	aSequenceOfRolls := SequenceOfDieForTesting withDie: {
			                    (LoadedDie rolling: 6).
			                    (LoadedDie rolling: 1).
			                    (LoadedDie rolling: 2) }.
	aGame := Game
		         playedBy: aGroupOfPlayers
		         withBoard: aTestBoard
		         withSetOfDie: aSequenceOfRolls
		         withLaps: 2.

	self play: 1 in: aGame.

	self assert: aGame playerPositions equals: assertingVariableData
]

{ #category : 'tests' }
GameplayTest >> test09LoopingOfTheLapWithRanking [

	| aGame aWormhole aTestBoard aSequenceOfRolls assertingVariableData |
	assertingVariableData := { 'Name: Juan, Place: 1'.
	                         'Name: Tomi, Place: 2' }.
	aWormhole := Wormhole createWith: 4.
	aTileListCreator at: 3 put: aWormhole.
	aTestBoard := Board createWith: aTileListCreator tileList.
	aSequenceOfRolls := SequenceOfDieForTesting withDie: {
			                    (LoadedDie rolling: 6).
			                    (LoadedDie rolling: 1).
			                    (LoadedDie rolling: 2) }.
	aGame := Game
		         playedBy: aGroupOfPlayers
		         withBoard: aTestBoard
		         withSetOfDie: aSequenceOfRolls
		         withLaps: 2.

	self play: 1 in: aGame.

	self assert: aGame playerRanking equals: assertingVariableData
]
