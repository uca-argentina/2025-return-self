Class {
	#name : 'GameplayBattleMechanicTest',
	#superclass : 'TestCase',
	#instVars : [
		'firstPlayer',
		'secondPlayer',
		'dieThrowSequence1',
		'aGroupOfPlayers'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'running' }
GameplayBattleMechanicTest >> setUp [
	super setUp.

	firstPlayer := Player named: 'Juan'.
	secondPlayer := Player named: 'Tomi'.
	aGroupOfPlayers := {
		                 firstPlayer.
		                 secondPlayer }.

	dieThrowSequence1 := SequenceOfDieForTesting 
		             withDie: {
				             LoadedDie rolling: 1.
				             LoadedDie rolling: 3 }.
				
	
	
]

{ #category : 'tests' }
GameplayBattleMechanicTest >> testBattleSituation [

	| aGame aLoadedDie aWormhole dieThrowSequence aTestBoard|
	dieThrowSequence := SequenceOfDieForTesting 
		             withDie: {
				             LoadedDie rolling: 2.
				             LoadedDie rolling: 2.
								 LoadedDie rolling: 1.
								 LoadedDie rolling: 5.}.
								
	aWormhole := Wormhole oneEnd: 4 otherEnd: 9.
	aTestBoard := BoardForTesting createWithTiles: 10 andEffects: {aWormhole}.
	aLoadedDie := dieThrowSequence .
	aGame := Game
		         playedBy: aGroupOfPlayers
		         withBoard: aTestBoard 
		         withSetOfDie: aLoadedDie
					withLaps: 1.
					
	aGame nextPlayerThrowsDice .
	aGame nextPlayerThrowsDice . "entran en combate, juan tira 1 tomi tira 5. juan pierde y vuelve al inicio"
	
	self assert:aGame playerPositions equals:{'Juan : 1 , lap: 0' . 'Tomi : 3 , lap: 0'}
	
]

{ #category : 'tests' }
GameplayBattleMechanicTest >> testBattleSituationThenKeepPlaying [

	| aGame aLoadedDie aWormhole dieThrowSequence aTestBoard|
	dieThrowSequence := SequenceOfDieForTesting 
		             withDie: {
				             LoadedDie rolling: 2.
				             LoadedDie rolling: 2.
								 LoadedDie rolling: 1.
								 LoadedDie rolling: 5.
								 LoadedDie rolling:3.
								 LoadedDie rolling:4.
								}.
								
	aWormhole := Wormhole oneEnd: 4 otherEnd: 9.
	aTestBoard := BoardForTesting createWithTiles: 10 andEffects: {aWormhole}.
	aLoadedDie := dieThrowSequence .
	aGame := Game
		         playedBy: aGroupOfPlayers
		         withBoard: aTestBoard 
		         withSetOfDie: aLoadedDie
					withLaps: 1.
					
	aGame nextPlayerThrowsDice . "tira 2"
	self assert:aGame playerPositions equals:{'Juan : 3 , lap: 0' . 'Tomi : 1 , lap: 0'}.
	aGame nextPlayerThrowsDice . "tira 2, entran en combate, juan tira 1 tomi tira 5. juan pierde y vuelve al inicio"
	self assert:aGame playerPositions equals:{'Juan : 1 , lap: 0' . 'Tomi : 3 , lap: 0'}.
	aGame nextPlayerThrowsDice ."tira 3"
	self assert:aGame playerPositions equals:{'Juan : 9 , lap: 0' . 'Tomi : 3 , lap: 0'}.
	aGame nextPlayerThrowsDice ."tira 4"
	self assert:aGame playerPositions equals:{'Juan : 9 , lap: 0' . 'Tomi : 7 , lap: 0'}.
	aGame nextPlayerThrowsDice ."tira 2"
	self assert:aGame playerPositions equals:{'Juan : 1 , lap: 1' . 'Tomi : 7 , lap: 0'}.
	self assert:aGame winner equals:'Juan'
	
]

{ #category : 'tests' }
GameplayBattleMechanicTest >> testLoopingOfTheLap [

	| aGame aLoadedDie aWormhole aTestBoard|
	aWormhole := Wormhole oneEnd: 3 otherEnd: 4.
	aTestBoard := BoardForTesting createWithTiles: 5 andEffects: {aWormhole}.
	aLoadedDie := LoadedDie rolling: 6.
	aGame := Game
		         playedBy: aGroupOfPlayers
		         withBoard: aTestBoard 
		         withSetOfDie: aLoadedDie
					withLaps: 2.
	
	self assert: aGame nextPlayerThrowsDice equals: 2.
	self assert:aGame playerPositions equals:{'Juan : 2 , lap: 1' . 'Tomi : 1 , lap: 0'}.
	
]

{ #category : 'tests' }
GameplayBattleMechanicTest >> testRunningOutOfShieldsAndSkippingTwoTurns [

	| aGame aLoadedDie aWormhole dieThrowSequence aTestBoard|
	dieThrowSequence := SequenceOfDieForTesting 
		             withDie: {
				             LoadedDie rolling: 1.
				             LoadedDie rolling: 1."caen en 2, batallan"
								 LoadedDie rolling: 1.
								 LoadedDie rolling: 5."gana tomi"
								
								 LoadedDie rolling: 2.
				             LoadedDie rolling: 1."caen en 3, batallan"
								 LoadedDie rolling: 1.
								 LoadedDie rolling: 5."gana tomi"
								
								LoadedDie rolling: 3.
				             LoadedDie rolling: 1."caen en 4, batallan"
								 LoadedDie rolling: 1.
								 LoadedDie rolling: 5."gana tomi"
								
								LoadedDie rolling: 1."juan saltea este turno"
								 LoadedDie rolling: 1."juan saltea este turno"
								LoadedDie rolling: 1."juan recupera escudos vuelve a jugar"
								LoadedDie rolling: 2. "Tomi pasa por el wormhole"
								
								LoadedDie rolling: 1."juan tira"
								LoadedDie rolling: 2. "Tomi termina el juego"
				}.
								
	aWormhole := Wormhole oneEnd: 8 otherEnd: 29.
	aTestBoard := BoardForTesting createWithTiles: 30 andEffects: { aWormhole }.
	aLoadedDie := dieThrowSequence .
	aGame := Game
		         playedBy: aGroupOfPlayers
		         withBoard: aTestBoard 
		         withSetOfDie: aLoadedDie
					withLaps: 1.
					
	aGame nextPlayerThrowsDice .
	self assert:aGame playerPositions equals:{'Juan : 2 , lap: 0' . 'Tomi : 1 , lap: 0'}.
	aGame nextPlayerThrowsDice .
	self assert:aGame playerPositions equals:{'Juan : 1 , lap: 0' . 'Tomi : 2 , lap: 0'}."gana tomi - juan tiene 2 escudos"
	
	aGame nextPlayerThrowsDice .
	self assert:aGame playerPositions equals:{'Juan : 3 , lap: 0' . 'Tomi : 2 , lap: 0'}.
	aGame nextPlayerThrowsDice .
	self assert:aGame playerPositions equals:{'Juan : 1 , lap: 0' . 'Tomi : 3 , lap: 0'}."gana tomi - juan tiene 1 escudo"
	
	aGame nextPlayerThrowsDice .
	self assert:aGame playerPositions equals:{'Juan : 4 , lap: 0' . 'Tomi : 3 , lap: 0'}.
	aGame nextPlayerThrowsDice .
	self assert:aGame playerPositions equals:{'Juan : 1 , lap: 0' . 'Tomi : 4 , lap: 0'}."gana tomi - juan no tiene mas escudos"
	
	aGame nextPlayerThrowsDice .
	self assert:aGame playerPositions equals:{'Juan : 1 , lap: 0' . 'Tomi : 5 , lap: 0'}."juan se saltea este turno - tomi tira"
	aGame nextPlayerThrowsDice .
	self assert:aGame playerPositions equals:{'Juan : 1 , lap: 0' . 'Tomi : 6 , lap: 0'}."juan se saltea este turno - tomi tira"
	
	aGame nextPlayerThrowsDice .
	self assert:aGame playerPositions equals:{'Juan : 2 , lap: 0' . 'Tomi : 6 , lap: 0'}."juan recupera los escudos - tira"
	aGame nextPlayerThrowsDice .
	self assert:aGame playerPositions equals:{'Juan : 2 , lap: 0' . 'Tomi : 29 , lap: 0'}."tomi tira - pasa por el wormhole"
	
	aGame nextPlayerThrowsDice .
	self assert:aGame playerPositions equals:{'Juan : 3 , lap: 0' . 'Tomi : 29 , lap: 0'}."juan tira"
	aGame nextPlayerThrowsDice .
	self assert:aGame playerPositions equals:{'Juan : 3 , lap: 0' . 'Tomi : 1 , lap: 1'}."tomi tira - termina el juego"
	
	self assert: aGame winner equals: 'Tomi'
	
]

{ #category : 'tests' }
GameplayBattleMechanicTest >> testSkippingTurnAndReplenishingShield [

	| aGame aLoadedDie aWormhole dieThrowSequence aTestBoard|
	dieThrowSequence := SequenceOfDieForTesting 
		             withDie: {
				             LoadedDie rolling: 1.
				             LoadedDie rolling: 1."caen en 2, batallan"
								 LoadedDie rolling: 1.
								 LoadedDie rolling: 5."gana tomi"
								"juan saltea turno"
								
								 LoadedDie rolling: 2."tira tomi"
				             LoadedDie rolling: 1."tira juan"
				}.
								
	aWormhole := Wormhole oneEnd: 8 otherEnd: 29.
	aTestBoard := BoardForTesting createWithTiles: 30 andEffects: { aWormhole }.
	aLoadedDie := dieThrowSequence .
	aGame := Game
		         playedBy: aGroupOfPlayers
		         withBoard: aTestBoard 
		         withSetOfDie: aLoadedDie
					withLaps: 1.
					
	aGame nextPlayerThrowsDice .
	self assert:aGame playerPositions equals:{'Juan : 2 , lap: 0' . 'Tomi : 1 , lap: 0'}.
	aGame nextPlayerThrowsDice .
	self assert:aGame playerPositions equals:{'Juan : 1 , lap: 0' . 'Tomi : 2 , lap: 0'}."gana tomi - juan tiene 2 escudos"
	
	aGame nextPlayerSkipsTurn."juan recupera escudos"
	self assert:aGame playerPositions equals:{'Juan : 1 , lap: 0' . 'Tomi : 2 , lap: 0'}.
	aGame nextPlayerThrowsDice ."tira tomi"
	self assert:aGame playerPositions equals:{'Juan : 1 , lap: 0' . 'Tomi : 4 , lap: 0'}.
	aGame nextPlayerThrowsDice ."tira juan"
	self assert:aGame playerPositions equals:{'Juan : 2 , lap: 0' . 'Tomi : 4 , lap: 0'}.



]
