Class {
	#name : 'GameplayBattleMechanicTest',
	#superclass : 'TestCase',
	#instVars : [
		'firstPlayer',
		'secondPlayer',
		'aSetOfPlayers',
		'dieThrowSequence1'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'running' }
GameplayBattleMechanicTest >> setUp [
	super setUp.

	firstPlayer := Player named: 'Juan'.
	secondPlayer := Player named: 'Tomi'.
	aSetOfPlayers := {
		                 firstPlayer.
		                 secondPlayer }.

	dieThrowSequence1 := SequenceOfDieForTesting 
		             withDie: {
				             LoadedDie rolling: 1.
				             LoadedDie rolling: 3 }.
				
	
	
]

{ #category : 'tests' }
GameplayBattleMechanicTest >> testBattleSituation [

	| aGame aLoadedDie aWormhole dieThrowSequence|
	dieThrowSequence := SequenceOfDieForTesting 
		             withDie: {
				             LoadedDie rolling: 2.
				             LoadedDie rolling: 2.
								 LoadedDie rolling: 1.
								 LoadedDie rolling: 5.}.
								
	aWormhole := Wormhole oneEnd: 4 otherEnd: 9.
	aLoadedDie := dieThrowSequence .
	aGame := Game
		         playedBy: aSetOfPlayers
		         withBoardLength: 10
		         withWormhole: aWormhole
		         withSetOfDie: aLoadedDie
					withLaps: 1.
					
	aGame nextPlayerThrowsDice .
	aGame nextPlayerThrowsDice . "entran en combate, juan tira 1 tomi tira 5. juan pierde y vuelve al inicio"
	
	self assert:aGame playerPositions equals:{'Juan : 1' . 'Tomi : 3'}
	
]

{ #category : 'tests' }
GameplayBattleMechanicTest >> testGamePlayedWithASingleLapNoBattles [

	| aGame aLoadedDie aWormhole |
	aWormhole := Wormhole oneEnd: 3 otherEnd: 9.
	aLoadedDie := dieThrowSequence1 .
	aGame := Game
		         playedBy: aSetOfPlayers
		         withBoardLength: 10
		         withWormhole: aWormhole
		         withSetOfDie: aLoadedDie
					withLaps: 1.
					
	aGame playFullGame.

	self assert: aGame winner equals: 'Tomi'
]

{ #category : 'tests' }
GameplayBattleMechanicTest >> testGamePlayedWithTwoLapsNoBattles [

	| aGame aLoadedDie aWormhole |
	aWormhole := Wormhole oneEnd: 3 otherEnd: 9.
	aLoadedDie := dieThrowSequence1 .
	aGame := Game
		         playedBy: aSetOfPlayers
		         withBoardLength: 10
		         withWormhole: aWormhole
		         withSetOfDie: aLoadedDie
					withLaps: 2.
					
	aGame playFullGame.

	self assert: aGame winner equals: 'Tomi'
]

{ #category : 'tests' }
GameplayBattleMechanicTest >> testLoopingOfTheLap [

	| aGame aLoadedDie aWormhole |
	aWormhole := Wormhole oneEnd: 3 otherEnd: 4.
	aLoadedDie := LoadedDie rolling: 6.
	aGame := Game
		         playedBy: aSetOfPlayers
		         withBoardLength: 5
		         withWormhole: aWormhole
		         withSetOfDie: aLoadedDie
					withLaps: 2.
	
	self assert: aGame nextPlayerThrowsDice equals: 2
]
