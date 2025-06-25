Class {
	#name : 'CardUsageTest',
	#superclass : 'GameplayFullInteractionTestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
CardUsageTest >> test01 [

	| aGame aLoadedDie  aTestBoard |
	aTestBoard := BoardForTesting createWith: aTileListCreator tileList.
	aLoadedDie := LoadedDie rolling: 4.
	aGame := Game
		         playedBy: aGroupOfPlayers
		         withBoard: aTestBoard
		         withSetOfDie: aLoadedDie
		         withLaps: 1.

	self play: 1 in: aGame.

	self assert: (aGame positionFeatureOf: aPlayer) position equals: 5
]
