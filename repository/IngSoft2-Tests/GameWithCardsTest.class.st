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
			                   with: Speed
			                   with: Acceleration).

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

{ #category : 'tests' }
GameWithCardsTest >> test02WhenUsingARepeatCardThenItTriggersTheLastEffectApplied [

	| aGame aSequence aTestBoard aCardGiverTile anotherPlayer |
	anotherPlayer:= aPlayer := ShipPlayerAssociation createWith: 2 and: 'Tomi'.
	aCardGiverTile := LoadedCardGiver createWith:
		                  (OrderedCollection
			                   with: Repeat).

	aTileListCreator at: 4 put: aCardGiverTile.
	aTileListCreator at: 6 put: BlackHole create.
	aTestBoard := Board createWith: aTileListCreator tileList.
	aSequence := SequenceOfDieForTesting withDie: {
			             (LoadedDie rolling: 3).
			             (LoadedDie rolling: 5).
			             (LoadedDie rolling: 4).
			             (LoadedDie rolling: 5) }.
	aGame := Game
		         playedBy: aGroupOfPlayers
		         withBoard: aTestBoard
		         withSetOfDie: aSequence
		         withLaps: 1.
	
self play:4 in: aGame.
	
	aGame playRepeatCardTargeting: anotherPlayer from: aPlayer .
	self assert: (aGame positionFeatureOf: aPlayer) position
		equals: 3
]

{ #category : 'tests' }
GameWithCardsTest >> test03WhenUsingACancellationCardThenItRemovesTheCardTargeted [
	| aGame aSequence aTestBoard aCard aCardGiverTile anotherPlayer |
	anotherPlayer:= ShipPlayerAssociation createWith: 2 and: 'Tomi'.
	aCardGiverTile := LoadedCardGiver createWith:
		                  (OrderedCollection
			                   with: Cancellation).

	aTileListCreator at: 4 put: aCardGiverTile.
	aTileListCreator at: 6 put: BlackHole create.
	aTestBoard := Board createWith: aTileListCreator tileList.
	aSequence := SequenceOfDieForTesting withDie: {
			             (LoadedDie rolling: 3).
			             (LoadedDie rolling: 5).
			             (LoadedDie rolling: 4).
			             (LoadedDie rolling: 5) }.
	aGame := Game
		         playedBy: aGroupOfPlayers
		         withBoard: aTestBoard
		         withSetOfDie: aSequence
		         withLaps: 1.
	
	self play:4 in: aGame.
	aCard := Speed create.
	self deny: (aGame activeCards ) equals: OrderedCollection new.
	aGame playCancelCardTargeting: aCard from: aPlayer .
	self assert: (aGame activeCards ) equals: OrderedCollection new.
]
