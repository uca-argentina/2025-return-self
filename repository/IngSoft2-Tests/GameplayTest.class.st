Class {
	#name : 'GameplayTest',
	#superclass : 'ReturnSelfTestCase',
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
		                   (ShipPlayerAssociation createWith: 1 and: 'Juan').
		                   (ShipPlayerAssociation createWith: 2 and: 'Tomi') }
]

{ #category : 'tests' }
GameplayTest >> test01WhenAGameIsPlayedWithASetOfDie [

	| aGame firstLoadedDice secondLoadedDice aWormhole aSetOfDie aTestBoard aPlayer |
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
	aPlayer := aGame nextPlayerThrowsDice.
	self assert: aPlayer position equals: 9
]

{ #category : 'tests' }
GameplayTest >> test02WhenAGameStartsTheresTheFirstTurn [

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
GameplayTest >> test03WhenTheGameIsAtTheSecondTurn [

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
GameplayTest >> test04WhenTheGamePlaysItselfThenThereIsAWinner [

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
GameplayTest >> test05WhenSteppingIntoWormhole [

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
GameplayTest >> test06WhenThereIsATurnAfterGameIsFinishedTHenItReturnsTheWinner [

	| aGame aLoadedDie aWormhole aTestBoard aWinner |
	aWormhole := Wormhole oneEnd: 3 otherEnd: 14.
	aTestBoard := BoardForTesting createWithTiles: 20 andEffects: { aWormhole }.
	aLoadedDie := LoadedDie rolling: 6.
	aGame := Game
		         playedBy: aGroupOfPlayers
		         withBoard: aTestBoard 
		         withSetOfDie: aLoadedDie 
					withLaps:1.

	aGame playFullGame.
	aWinner := aGame nextPlayerThrowsDice.
	self assert: (aWinner equalsName: 'Tomi')
]

{ #category : 'tests' }
GameplayTest >> test07GamePlayedWithASingleLapNoBattles [

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
GameplayTest >> test08LoopingOfTheLap [

	| aGame aLoadedDie aWormhole aTestBoard|
	aWormhole := Wormhole oneEnd: 3 otherEnd: 4.
	aTestBoard := BoardForTesting createWithTiles: 5 andEffects: { aWormhole }.
	aLoadedDie := LoadedDie rolling: 6.
	aGame := Game
		         playedBy: aGroupOfPlayers
		         withBoard: aTestBoard
		         withSetOfDie: aLoadedDie
					withLaps: 2.
	
	self assert: aGame nextPlayerThrowsDice equals: 2.
	self assert:aGame playerPositions equals:{'Juan : 2 , lap: 1' . 'Tomi : 1 , lap: 0'}.
]
