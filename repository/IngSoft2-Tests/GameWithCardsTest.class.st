Class {
	#name : 'GameWithCardsTest',
	#superclass : 'GameplayFullInteractionTestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
GameWithCardsTest >> test01GamePlayedWithACardGiverTile [

	| aGame aCardGiverTile aSequence aTestBoard shipCardsOfJuan shipCardsOfTomi |
	aCardGiverTile := LoadedCardGiver createWith:
		                  (OrderedCollection
			                   with: Speed create
			                   with: Acceleration create).

	aTileListCreator at: 4 put: aCardGiverTile.
	aTestBoard := Board createWith: aTileListCreator tileList.
	aSequence := SequenceOfDieForTesting withDie: {
			             (LoadedDie rolling: 3).
			             (LoadedDie rolling: 3).
			             (LoadedDie rolling: 1).
			             (LoadedDie rolling: 5) }.
	aGame := Game
		         playedBy: aGroupOfPlayers
		         withBoard: aTestBoard
		         withSetOfDie: aSequence
		         withLaps: 1.

	aGame playFullGame. "por alguna razon se traba despues del primer tiro"

	shipCardsOfJuan := aGame cardsFeatureOf: (aGroupOfPlayers at: 1).


	shipCardsOfTomi := aGame cardsFeatureOf: (aGroupOfPlayers at: 2).

	self assert: (shipCardsOfJuan deck at: 3) isSpeed equals: true.
	self assert: (shipCardsOfTomi deck at: 3) isAcceleration equals: true
]
