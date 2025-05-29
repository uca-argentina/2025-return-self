Class {
	#name : 'EffectTest',
	#superclass : 'TestCase',
	#instVars : [
		'firstPlayer',
		'secondPlayer',
		'aSetOfPlayers'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'running' }
EffectTest >> setUp [
	super setUp.

	firstPlayer := Player named: 'Juan'.
	secondPlayer := Player named: 'Tomi'.
	aSetOfPlayers := {
		                 firstPlayer.
		                 secondPlayer }
]

{ #category : 'tests' }
EffectTest >> testGamePlayedWithABlackHoleTile [
	| aGame aLoadedDie aBlackHoleTile aSecondLoadedDie aSequence|
	aBlackHoleTile := BlackHole initializeInTile: 4 withDebuff: 4.
	aLoadedDie := LoadedDie rolling: 2.
	aSecondLoadedDie := LoadedDie rolling: 3.
	aSequence := SequenceOfDieForTesting 
		             withDie: {
				             aLoadedDie.
				             aSecondLoadedDie }.
	aGame := Game
		         playedBy: aSetOfPlayers
		         withBoardLength: 20
		         withEffect: aBlackHoleTile
		         withSetOfDie: aSequence
					withLaps: 1.
					
	aGame playFullGame.

	self assert: aGame winner equals: 'Juan' "gana juan porque tomi se queda en un loop hasta que gane juan a proposito"

]

{ #category : 'tests' }
EffectTest >> testGamePlayedWithAHyperJumpTile [
	| aGame aLoadedDie aHSTile aSecondLoadedDie aSequence|
	aHSTile := HyperJump initializeOnTile: 3 .
	aLoadedDie := LoadedDie rolling: 1. "1 2 12 13 14 15 16"
	aSecondLoadedDie := LoadedDie rolling: 2. "1 13 15 17 19 21"
	aSequence := SequenceOfDieForTesting 
		             withDie: {
				             aLoadedDie.
				             aSecondLoadedDie }.
	aGame := Game
		         playedBy: aSetOfPlayers
		         withBoardLength: 20
		         withEffect: aHSTile
		         withSetOfDie: aSequence
					withLaps: 1.
					
	aGame nextPlayerThrowsDice.
	aGame nextPlayerThrowsDice.
	aGame nextPlayerThrowsDice.

	self assert:aGame playerPositions equals:{'Juan : 12 , lap: 0, shields: 3' . 'Tomi : 13 , lap: 0, shields: 3'}

	"self assert: aGame winner equals: 'Juan' "

]

{ #category : 'tests' }
EffectTest >> testGamePlayedWithAHyperSpaceJumpTile [
	| aGame aLoadedDie aHSJTile aSecondLoadedDie aSequence|
	aHSJTile := HyperSpaceJump initializeOnTile: 4.
	aLoadedDie := LoadedDie rolling: 4. "1 5 9 13 17 21"
	aSecondLoadedDie := LoadedDie rolling: 3. "1 4 14 17 21"
	aSequence := SequenceOfDieForTesting 
		             withDie: {
				             aLoadedDie.
				             aSecondLoadedDie }.
	aGame := Game
		         playedBy: aSetOfPlayers
		         withBoardLength: 20
		         withEffect: aHSJTile
		         withSetOfDie: aSequence
					withLaps: 1.
					
	aGame nextPlayerThrowsDice.
	aGame nextPlayerThrowsDice.
	self assert:aGame playerPositions equals:{'Juan : 5 , lap: 0, shields: 3' . 'Tomi : 14 , lap: 0, shields: 2'}

	"self assert: aGame winner equals: 'Juan' "

]

{ #category : 'tests' }
EffectTest >> testGamePlayedWithAMoonWalkTile [
	| aGame aLoadedDie aMoonWalkTile aSecondLoadedDie aSequence|
	aMoonWalkTile := MoonWalk initializeInTile: 15 withDebuff: 11 andSetOfPlayers: aSetOfPlayers.
	aLoadedDie := LoadedDie rolling: 7. 	     
	aSecondLoadedDie := LoadedDie rolling: 8. 
	aSequence := SequenceOfDieForTesting 
		             withDie: {
				             aLoadedDie.
				             aSecondLoadedDie }.
	aGame := Game
		         playedBy: aSetOfPlayers
		         withBoardLength: 24
		         withEffect: aMoonWalkTile
		         withSetOfDie: aSequence
					withLaps: 1.
					
	aGame playFullGame.

	self assert: aGame winner equals: 'Juan' 
]

{ #category : 'tests' }
EffectTest >> testGamePlayedWithANoEffectTile [
	| aGame aLoadedDie aNoEffectTile aSecondLoadedDie aSequence|
	aNoEffectTile := NoEffect new.
	aLoadedDie := LoadedDie rolling: 4. 	     
	aSecondLoadedDie := LoadedDie rolling: 1. 
	aSequence := SequenceOfDieForTesting 
		             withDie: {
				             aLoadedDie.
				             aSecondLoadedDie }.
	aGame := Game
		         playedBy: aSetOfPlayers
		         withBoardLength: 20
		         withEffect: aNoEffectTile
		         withSetOfDie: aSequence
					withLaps: 1.
					
	aGame playFullGame.

	self assert: aGame winner equals: 'Juan'

]

{ #category : 'tests' }
EffectTest >> testGamePlayedWithAbannana [
	| aGame aLoadedDie  aSecondLoadedDie aSequence  aBoard aMoonWalkTile aHSJTile aBlackHoleTile|
	aHSJTile := HyperSpaceJump initializeOnTile: 4 .
	aMoonWalkTile := MoonWalk initializeInTile: 15 withDebuff: 11 andSetOfPlayers: aSetOfPlayers.
	aBlackHoleTile := BlackHole initializeInTile: 2 withDebuff: 4.
	aBoard := Board createWithTiles: 20 andEffects: 
		  { aHSJTile. aMoonWalkTile. aBlackHoleTile }.
	aLoadedDie := LoadedDie rolling: 7. 	     
	aSecondLoadedDie := LoadedDie rolling: 8. 
	aSequence := SequenceOfDieForTesting 
		             withDie: {
				             aLoadedDie.
				             aSecondLoadedDie }.
	aGame := Game
		         playedBy: aSetOfPlayers
		         withBoard: aBoard
		         withSetOfDie: aSequence
					withLaps: 1.
					
	aGame playFullGame.

	self assert: aGame winner equals: 'Juan' 
]

{ #category : 'tests' }
EffectTest >> testGamePlayedWithAbannana123 [
	| aGame aLoadedDie  aSecondLoadedDie aSequence  aBoard|

	aBoard := Board createWithTiles: 20.
	aLoadedDie := LoadedDie rolling: 7. 	     
	aSecondLoadedDie := LoadedDie rolling: 8. 
	aSequence := SequenceOfDieForTesting 
		             withDie: {
				             aLoadedDie.
				             aSecondLoadedDie }.
	aGame := Game
		         playedBy: aSetOfPlayers
		         withBoard: aBoard
		         withSetOfDie: aSequence
					withLaps: 1.
					
	aGame playFullGame.

	self assert: aGame winner equals: 'Juan' 
]

{ #category : 'tests' }
EffectTest >> testGamePlayedWithAnAtomikBombTile [
	| aGame aSequence anAtomikBomb |
	anAtomikBomb := AtomikBomb initializeInTile: 7 andSetOfPlayers: aSetOfPlayers.
	aSequence := SequenceOfDieForTesting 
		             withDie: {
								LoadedDie rolling: 3.
								LoadedDie rolling: 4.
								LoadedDie rolling: 3.
								LoadedDie rolling: 2.
				             }.
	aGame := Game
		         playedBy: aSetOfPlayers
		         withBoardLength: 24
		         withEffect: anAtomikBomb
		         withSetOfDie: aSequence
					withLaps: 1.
					
	aGame nextPlayerThrowsDice .
	self assert:aGame playerPositions equals:{'Juan : 4 , lap: 0, shields: 3' . 'Tomi : 1 , lap: 0, shields: 3'}.
	
	aGame nextPlayerThrowsDice .
	self assert:aGame playerPositions equals:{'Juan : 4 , lap: 0, shields: 3' . 'Tomi : 5 , lap: 0, shields: 3'}.
	
	aGame nextPlayerThrowsDice .
	self assert:aGame playerPositions equals:{'Juan : 1 , lap: 0, shields: 2' . 'Tomi : 1 , lap: 0, shields: 2'}.
	
	aGame nextPlayerThrowsDice .
	self assert:aGame playerPositions equals:{'Juan : 1 , lap: 0, shields: 2' . 'Tomi : 3 , lap: 0, shields: 2'}.



]

{ #category : 'tests' }
EffectTest >> testWhenWeCreateAWormholeWithAtLeastOneEndLessThanOneThenItRaisesAnError [

	| anErrorHandler |
	anErrorHandler := ReturnSelfErrorHandler usingTestCase: self.

	anErrorHandler
		should: [ Wormhole oneEnd: -10 otherEnd: 2 ]
		raiseErrorWithMessageText:
		'Both ends of the Wormhole must be greater than 1.'.
	anErrorHandler
		should: [ Wormhole oneEnd: 2 otherEnd: -10 ]
		raiseErrorWithMessageText:
		'Both ends of the Wormhole must be greater than 1.'.
	anErrorHandler
		should: [ Wormhole oneEnd: -10 otherEnd: -10 ]
		raiseErrorWithMessageText:
		'Both ends of the Wormhole must be greater than 1.'
]

{ #category : 'tests' }
EffectTest >> testWhenWeCreateAWormholeWithEqualEndsThenItRaisesAnError [

	| anErrorHandler |
	anErrorHandler := ReturnSelfErrorHandler usingTestCase: self.
	anErrorHandler
		should: [ Wormhole oneEnd: 2 otherEnd: 2 ]
		raiseErrorWithMessageText: 'Wormhole ends must be different tiles.'
]
