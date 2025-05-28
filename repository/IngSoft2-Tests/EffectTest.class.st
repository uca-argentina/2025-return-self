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
EffectTest >> testGamePlayedWithAMoonWalkTile [
	| aGame aLoadedDie aMoonWalkTile aSecondLoadedDie aSequence|
	aMoonWalkTile := MoonWalk initializeInTile: 15 withDebuff: 11 andSetOfPlayers: aSetOfPlayers.
	aLoadedDie := LoadedDie rolling: 2. 	     "1 3 5 7 9 11 13 15 17 19 21"
	aSecondLoadedDie := LoadedDie rolling: 3. "1 4 7 10 13 16 19 22"
	aSequence := SequenceOfDieForTesting 
		             withDie: {
				             aLoadedDie.
				             aSecondLoadedDie }.
	aGame := Game
		         playedBy: aSetOfPlayers
		         withBoardLength: 20
		         withEffect: aMoonWalkTile
		         withSetOfDie: aSequence
					withLaps: 1.
					
	aGame playFullGame.

	self assert: aGame winner equals: 'Juan' 
]

{ #category : 'tests' }
EffectTest >> testGamePlayedWithANoEffectTile [
	| aGame aLoadedDie aNoEffectTile |
	aNoEffectTile := NoEffect new.
	aLoadedDie := LoadedDie rolling: 4.
	aGame := Game
		         playedBy: aSetOfPlayers
		         withBoardLength: 20
		         withEffect: aNoEffectTile
		         withSetOfDie: aLoadedDie
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
