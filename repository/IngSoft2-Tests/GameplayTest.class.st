Class {
	#name : 'GameplayTest',
	#superclass : 'TestCase',
	#instVars : [
		'aGroupOfPlayers'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'running' }
GameplayTest >> setUp [

	super setUp.
	aGroupOfPlayers := {
		                   (ShipPosition createWith: 1 and: 'Juan').
		                   (ShipPosition createWith: 2 and: 'Tomi') }
]

{ #category : 'tests' }
GameplayTest >> testGamePlayedWithASingleLapNoBattles [

	| aGame aLoadedDie aWormhole aTestBoard|
	aWormhole := Wormhole oneEnd: 3 otherEnd: 14.
	aTestBoard := BoardForTesting createWithTiles: 20 andEffects: { aWormhole }.
	aLoadedDie := LoadedDie rolling: 4.
	aGame := Game
		         playedBy: aGroupOfPlayers
		         withBoard: aTestBoard 
		         withSetOfDie: aLoadedDie
					withLaps: 1.
					
	aGame playFullGame.

	self assert: (aGame isWinner: 'Tomi') 
"
	aGame nextPlayerThrowsDice.
	aGame nextPlayerThrowsDice.

	self assert: aGame nextPlayerThrowsDice equals: 9"
]

{ #category : 'tests' }
GameplayTest >> testLoopingOfTheLap [

	| aGame aLoadedDie aWormhole aTestBoard|
	aWormhole := Wormhole oneEnd: 3 otherEnd: 4.
	aTestBoard := BoardForTesting createWithTiles: 5 andEffects: { aWormhole }.
	aLoadedDie := LoadedDie rolling: 6.
	aGame := Game
		         playedBy: aGroupOfPlayers
		         withBoard: aTestBoard
		         withSetOfDie: aLoadedDie
					withLaps: 2.
	
	self assert: aGame nextPlayerThrowsDice equals: 2
]

{ #category : 'tests' }
GameplayTest >> testWhenAGameIsPlayedWithASetOfDie [

	| aGame firstLoadedDice secondLoadedDice aWormhole aSetOfDie aTestBoard|
	aWormhole := Wormhole oneEnd: 5 otherEnd: 14.
	aTestBoard := BoardForTesting createWithTiles: 20 andEffects: { aWormhole }.
	firstLoadedDice := LoadedDie rolling: 3.
	secondLoadedDice := LoadedDie rolling: 5.
	aSetOfDie := DieSet having: {
			             firstLoadedDice.
			             secondLoadedDice }.
	aGame := Game
		         playedBy: aGroupOfPlayers
		         withBoard: aTestBoard
		         withSetOfDie: aSetOfDie
					withLaps:1.
	self assert: aGame nextPlayerThrowsDice equals: 9
]

{ #category : 'tests' }
GameplayTest >> testWhenAGameStartsTheresTheFirstTurn [

	| aGame aLoadedDie aWormhole aTestBoard|
	aWormhole := Wormhole oneEnd: 3 otherEnd: 14.
	aTestBoard := BoardForTesting createWithTiles: 20 andEffects: { aWormhole }.
	aLoadedDie := LoadedDie rolling: 4.
	aGame := Game
		         playedBy: aGroupOfPlayers
		         withBoard: aTestBoard 
		         withSetOfDie: aLoadedDie
					withLaps: 1.



	self assert: aGame nextPlayerThrowsDice equals: 5
]

{ #category : 'tests' }
GameplayTest >> testWhenSteppingIntoWormhole [

	| aGame aLoadedDie aWormhole aTestBoard|
	aWormhole := Wormhole oneEnd: 5 otherEnd: 14.
	aTestBoard := BoardForTesting createWithTiles: 30 andEffects: { aWormhole }.
	aLoadedDie := LoadedDie rolling: 4.
	aGame := Game
		         playedBy: aGroupOfPlayers
		         withBoard: aTestBoard 
		         withSetOfDie: aLoadedDie
					withLaps: 1.


	aGame nextPlayerThrowsDice.
	"Steps on wormhole here, on next turn it goes through."
	self assert: aGame nextPlayerThrowsDice equals: 14
]

{ #category : 'tests' }
GameplayTest >> testWhenTheGameIsAtTheSecondTurn [

	| aGame aLoadedDie aWormhole aTestBoard|
	aWormhole := Wormhole oneEnd: 3 otherEnd: 14.
	aTestBoard := BoardForTesting createWithTiles: 20 andEffects: { aWormhole }.
	aLoadedDie := LoadedDie rolling: 4.
	aGame := Game
		         playedBy: aGroupOfPlayers
		         withBoard: aTestBoard 
		         withSetOfDie: aLoadedDie
					withLaps: 1.

	aGame nextPlayerThrowsDice.

	self assert: aGame nextPlayerThrowsDice equals: 5
]

{ #category : 'tests' }
GameplayTest >> testWhenTheGameIsAtTheThirdTurn [

	| aGame aLoadedDie aWormhole aTestBoard|
	aWormhole := Wormhole oneEnd: 3 otherEnd: 14.
	aTestBoard := BoardForTesting createWithTiles: 20 andEffects: { aWormhole }.
	aLoadedDie := LoadedDie rolling: 4.
	aGame := Game
		         playedBy: aGroupOfPlayers
		         withBoard: aTestBoard 
		         withSetOfDie: aLoadedDie
					withLaps: 1.

	aGame nextPlayerThrowsDice.
	aGame nextPlayerThrowsDice.

	self assert: aGame nextPlayerThrowsDice equals: 1
]

{ #category : 'tests' }
GameplayTest >> testWhenTheGamePlaysItselfThenThereIsAWinner [

	| aGame aLoadedDie aWormhole aTestBoard|
	aWormhole := Wormhole oneEnd: 3 otherEnd: 14.
	aTestBoard := BoardForTesting createWithTiles: 20 andEffects: { aWormhole }.
	aLoadedDie := LoadedDie rolling: 4.
	aGame := Game
		         playedBy: aGroupOfPlayers
		         withBoard: aTestBoard
		         withSetOfDie: aLoadedDie
					withLaps: 1.

	aGame playFullGame.

	self assert: (aGame isWinner: 'Tomi') 
]

{ #category : 'tests' }
GameplayTest >> testWhenThereIsATurnAfterGameIsFinishedTHenItIsInvalid [

	| aGame aLoadedDie aWormhole aTestBoard|
	aWormhole := Wormhole oneEnd: 3 otherEnd: 14.
	aTestBoard := BoardForTesting createWithTiles: 20 andEffects: { aWormhole }.
	aLoadedDie := LoadedDie rolling: 6.
	aGame := Game
		         playedBy: aGroupOfPlayers
		         withBoard: aTestBoard 
		         withSetOfDie: aLoadedDie 
					withLaps:1.

	aGame playFullGame.

	self assert: aGame nextPlayerThrowsDice equals: aGame
]
