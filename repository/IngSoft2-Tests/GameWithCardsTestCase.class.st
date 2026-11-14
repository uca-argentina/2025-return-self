Class {
	#name : 'GameWithCardsTestCase',
	#superclass : 'GameplayFullInteractionTestCase',
	#instVars : [
		'anotherPlayer'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'testing' }
GameWithCardsTestCase class >> isAbstract [

	^ self == GameWithCardsTestCase
]

{ #category : 'running' }
GameWithCardsTestCase >> gameDealing: aSequenceOfCardKinds rolling: aSequenceOfRolls [

	^ Game
		playedBy: aGroupOfPlayers
		withBoard: (Board createWith: aTileListCreator tileList)
		withSetOfDie: (SequenceOfDieForTesting withDie:
				(aSequenceOfRolls collect: [ :aRoll | LoadedDie rolling: aRoll ]))
		withLaps: 1
		withCardDealer: (LoadedCardDealer dealing: aSequenceOfCardKinds)
]

{ #category : 'running' }
GameWithCardsTestCase >> setUp [

	super setUp.
	anotherPlayer := ShipPlayerAssociation createWith: 2 and: 'Tomi'
]
