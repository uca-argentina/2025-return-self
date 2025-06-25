Class {
	#name : 'CardUsageTest',
	#superclass : 'GameplayFullInteractionTestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
CardUsageTest >> test01 [

	| aGame aLoadedDie  aTestBoard aCardCollection1 |
	"aCardCollection1 := ShipCards createWith: (aGroupOfPlayers at:1 id) and: (OrderedCollection with:Card new with:Card new)."
	"aCardCollection2 := ShipCards createWith: (aGroupOfPlayers at:2 id) and: (OrderedCollection with:Card new with:Card new)."
	aCardCollection1 := (OrderedCollection with:Card ).
	aTestBoard := BoardForTestingWithCards createWith: aTileListCreator tileList and: aCardCollection1 .
	aLoadedDie := LoadedDie rolling: 4.
	aGame := Game
		         playedBy: aGroupOfPlayers
		         withBoard: aTestBoard
		         withSetOfDie: aLoadedDie
		         withLaps: 1.

	self play: 1 in: aGame.

	self assert: (aGame positionFeatureOf: aPlayer) position equals: 5
]
