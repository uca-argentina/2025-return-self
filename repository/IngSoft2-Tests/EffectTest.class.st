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
	aHSTile := HyperJump initializeInTile: 3 withBuff: 10.
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
	aHSJTile := HyperSpaceJump initializeInTile: 4 withBuff: 10.
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
