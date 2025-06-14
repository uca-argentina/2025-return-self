Class {
	#name : 'EffectTest',
	#superclass : 'TestCase',
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
		                   (ShipPosition named: 'Juan').
		                   (ShipPosition named: 'Tomi') }
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

	| aGame aLoadedDie aHSTile aSecondLoadedDie aSequence aTestBoard |
	aHSTile := HyperJump createOnTile: 3.
	aTestBoard := BoardForTesting
		              createWithTiles: 20
		              andEffects: (Array with: aHSTile).
	aLoadedDie := LoadedDie rolling: 1.
	aSecondLoadedDie := LoadedDie rolling: 2.
	aSequence := SequenceOfDieForTesting withDie: {
			             aLoadedDie.
			             aSecondLoadedDie }.
	aGame := Game
		         playedBy: aGroupOfPlayers
		         withBoard: aTestBoard
		         withSetOfDie: aSequence
		         withLaps: 1.
	aGame nextPlayerThrowsDice.
	aGame nextPlayerThrowsDice.
	aGame nextPlayerThrowsDice.
	
	self
		assert: aGame playerPositions
		equals: { 'Juan : 7 , lap: 0'. 'Tomi : 8 , lap: 0' }
]

{ #category : 'tests' }
EffectTest >> testGamePlayedWithAHyperSpaceJumpTile [
	| aGame aLoadedDie aHSJTile aSecondLoadedDie aSequence aTestBoard|
	aHSJTile := HyperSpaceJump createOnTile: 4.
	aTestBoard:= BoardForTesting createWithTiles: 20 andEffects: (Array with: aHSJTile ).
	aLoadedDie := LoadedDie rolling: 4. "1 5 9 13 17 21"
	aSecondLoadedDie := LoadedDie rolling: 3. "1 4 14 17 21"
	aSequence := SequenceOfDieForTesting 
		             withDie: {
				             aLoadedDie.
				             aSecondLoadedDie }.
	aGame := Game
		         playedBy: aGroupOfPlayers
		         withBoard: aTestBoard 
		         withSetOfDie: aSequence
					withLaps: 1.
					
	aGame nextPlayerThrowsDice.
	aGame nextPlayerThrowsDice.
	self assert:aGame playerPositions equals:{'Juan : 5 , lap: 0' . 'Tomi : 8 , lap: 0'}

	"self assert: aGame winner equals: 'Juan' "

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
	| aGame aLoadedDie aWormhole aSequence aTestBoard|
	aWormhole := Wormhole oneEnd: 3 otherEnd: 19.
	aTestBoard:= BoardForTesting createWithTiles: 20 andEffects: (Array with: aWormhole ).
	aLoadedDie := LoadedDie rolling: 2.
	aSequence := SequenceOfDieForTesting 
		             withDie: {
				             aLoadedDie.
									}.
	aGame := Game
		         playedBy: aGroupOfPlayers
		         withBoard: aTestBoard 
		         withSetOfDie: aSequence
					withLaps: 1.
					
	aGame nextPlayerThrowsDice.
	self assert:aGame playerPositions equals:{'Juan : 19 , lap: 0' . 'Tomi : 1 , lap: 0'}

	"self assert: aGame winner equals: 'Juan' "

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
	| aGame aSequence anAtomikBomb aTestBoard|
	anAtomikBomb := AtomikBomb createOnTile: 7."initializeOnTile: 7 andSetOfPlayers: aSetOfPlayers."
	aTestBoard := BoardForTesting createWithTiles: 24 andEffects: { anAtomikBomb }.
	aSequence := SequenceOfDieForTesting 
		             withDie: {
								LoadedDie rolling: 3.
								LoadedDie rolling: 4.
								LoadedDie rolling: 3.
								LoadedDie rolling: 2.
				             }.
	aGame := Game
		         playedBy: aGroupOfPlayers
		         withBoard: aTestBoard 
		         withSetOfDie: aSequence
					withLaps: 1.
					
	aGame nextPlayerThrowsDice .
	self assert:aGame playerPositions equals:{'Juan : 4 , lap: 0' . 'Tomi : 1 , lap: 0'}.
	
	aGame nextPlayerThrowsDice .
	self assert:aGame playerPositions equals:{'Juan : 4 , lap: 0' . 'Tomi : 5 , lap: 0'}.
	
	aGame nextPlayerThrowsDice .
	self assert:aGame playerPositions equals:{'Juan : 1 , lap: 0' . 'Tomi : 1 , lap: 0'}.
	
	aGame nextPlayerThrowsDice .
	self assert:aGame playerPositions equals:{'Juan : 1 , lap: 0' . 'Tomi : 3 , lap: 0'}.



]
