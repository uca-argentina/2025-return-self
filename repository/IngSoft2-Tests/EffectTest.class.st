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
	| aGame aLoadedDie aBlackHoleTile aSecondLoadedDie aSequence aTestBoard|
	aBlackHoleTile := BlackHole createOnTile: 4.
	aTestBoard := BoardForTesting createWithTiles: 20 andEffects: { aBlackHoleTile }.
	aLoadedDie := LoadedDie rolling: 2.
	aSecondLoadedDie := LoadedDie rolling: 3.
	aSequence := SequenceOfDieForTesting 
		             withDie: {
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

	| tmp1 tmp2 tmp3 tmp4 tmp5 tmp6 |
	tmp3 := HyperJump createOnTile: 3.
	tmp6 := BoardForTesting
		        createWithTiles: 20
		        andEffects: (Array with: tmp3).
	tmp2 := LoadedDie rolling: 1.
	tmp4 := LoadedDie rolling: 2.
	tmp5 := SequenceOfDieForTesting withDie: {
			        tmp2.
			        tmp4 }.
	tmp1 := Game
		        playedBy: aGroupOfPlayers
		        withBoard: tmp6
		        withSetOfDie: tmp5
		        withLaps: 1.
	tmp1
		nextPlayerThrowsDice;
		nextPlayerThrowsDice;
		nextPlayerThrowsDice.
	self
		assert: tmp1 playerPositions
		equals: { 'Juan : 7 , lap: 0'. 'Tomi : 8 , lap: 0' }
]

{ #category : 'tests' }
EffectTest >> testGamePlayedWithAHyperSpaceJumpTile [

	| tmp1 tmp2 tmp3 tmp4 tmp5 tmp6 |
	tmp3 := HyperSpaceJump createOnTile: 4.
	tmp6 := BoardForTesting
		        createWithTiles: 20
		        andEffects: (Array with: tmp3).
	tmp2 := LoadedDie rolling: 4.
	tmp4 := LoadedDie rolling: 3.
	tmp5 := SequenceOfDieForTesting withDie: {
			        tmp2.
			        tmp4 }.
	tmp1 := Game
		        playedBy: aGroupOfPlayers
		        withBoard: tmp6
		        withSetOfDie: tmp5
		        withLaps: 1.
	tmp1
		nextPlayerThrowsDice;
		nextPlayerThrowsDice.
	self
		assert: tmp1 playerPositions
		equals: { 'Juan : 5 , lap: 0'. 'Tomi : 8 , lap: 0' }
]

{ #category : 'tests' }
EffectTest >> testGamePlayedWithAMoonWalkTile [
	| aGame aLoadedDie aMoonWalkTile aSecondLoadedDie aSequence aTestBoard|
	aMoonWalkTile := MoonWalk createOnTile: 15 withDebuff: 11.
	aTestBoard:= BoardForTesting createWithTiles: 24 andEffects: (Array with: aMoonWalkTile ).
	aLoadedDie := LoadedDie rolling: 7. 	     
	aSecondLoadedDie := LoadedDie rolling: 8. 
	aSequence := SequenceOfDieForTesting 
		             withDie: {
				             aLoadedDie.
				             aSecondLoadedDie }.
	aGame := Game
		         playedBy: aGroupOfPlayers
		         withBoard: aTestBoard 
		         withSetOfDie: aSequence
					withLaps: 1.
					
	aGame playFullGame.

	self assert: (aGame isWinner: 'Juan') 
]

{ #category : 'tests' }
EffectTest >> testGamePlayedWithANoEffectTile [
	| aGame aLoadedDie aNoEffectTile aSecondLoadedDie aSequence aTestBoard|
	aNoEffectTile := NoEffect new.
	aTestBoard:= BoardForTesting createWithTiles: 20 andEffects: (Array with: aNoEffectTile ).
	aLoadedDie := LoadedDie rolling: 4. 	     
	aSecondLoadedDie := LoadedDie rolling: 1. 
	aSequence := SequenceOfDieForTesting 
		             withDie: {
				             aLoadedDie.
				             aSecondLoadedDie }.
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

	| tmp1 tmp2 tmp3 tmp4 tmp5 |
	tmp3 := Wormhole oneEnd: 3 otherEnd: 19.
	tmp5 := BoardForTesting
		        createWithTiles: 20
		        andEffects: (Array with: tmp3).
	tmp2 := LoadedDie rolling: 2.
	tmp4 := SequenceOfDieForTesting withDie: { tmp2 }.
	tmp1 := Game
		        playedBy: aGroupOfPlayers
		        withBoard: tmp5
		        withSetOfDie: tmp4
		        withLaps: 1.
	tmp1 nextPlayerThrowsDice.
	self
		assert: tmp1 playerPositions
		equals: { 'Juan : 19 , lap: 0'. 'Tomi : 1 , lap: 0' }
]

{ #category : 'tests' }
EffectTest >> testGamePlayedWithAllEffectsInAParticularTile [
	| aGame aLoadedDie  aSecondLoadedDie aSequence  aTestBoard aMoonWalkTile aHSJTile aBlackHoleTile|
	aHSJTile := HyperSpaceJump createOnTile: 4 .
	aMoonWalkTile := MoonWalk createOnTile: 15 withDebuff: 11.
	aBlackHoleTile := BlackHole createOnTile: 2.
	aTestBoard := BoardForTesting createWithTiles: 20 andEffects: 
		  { aHSJTile. aMoonWalkTile. aBlackHoleTile }.
	aLoadedDie := LoadedDie rolling: 7. 	     
	aSecondLoadedDie := LoadedDie rolling: 8. 
	aSequence := SequenceOfDieForTesting 
		             withDie: {
				             aLoadedDie.
				             aSecondLoadedDie }.
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

	| tmp1 tmp2 tmp3 tmp4 |
	tmp3 := AtomikBomb createOnTile: 7.
	tmp4 := BoardForTesting createWithTiles: 24 andEffects: { tmp3 }.
	tmp2 := SequenceOfDieForTesting withDie: {
			        (LoadedDie rolling: 3).
			        (LoadedDie rolling: 4).
			        (LoadedDie rolling: 3).
			        (LoadedDie rolling: 2) }.
	tmp1 := Game
		        playedBy: aGroupOfPlayers
		        withBoard: tmp4
		        withSetOfDie: tmp2
		        withLaps: 1.
	tmp1 nextPlayerThrowsDice.
	self
		assert: tmp1 playerPositions
		equals: { 'Juan : 4 , lap: 0'. 'Tomi : 1 , lap: 0' }.
	tmp1 nextPlayerThrowsDice.
	self
		assert: tmp1 playerPositions
		equals: { 'Juan : 4 , lap: 0'. 'Tomi : 5 , lap: 0' }.
	tmp1 nextPlayerThrowsDice.
	self
		assert: tmp1 playerPositions
		equals: { 'Juan : 1 , lap: 0'. 'Tomi : 1 , lap: 0' }.
	tmp1 nextPlayerThrowsDice.
	self
		assert: tmp1 playerPositions
		equals: { 'Juan : 1 , lap: 0'. 'Tomi : 3 , lap: 0' }
]
