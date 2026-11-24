Class {
	#name : 'SkipCardTest',
	#superclass : 'GameWithCardsTestCase',
	#instVars : [
		'aThirdPlayer'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'running' }
SkipCardTest >> setUp [

	super setUp.
	aThirdPlayer := ShipPlayerAssociation createWith: 3 and: 'Pedro'.
	aGroupOfPlayers := aGroupOfPlayers , { aThirdPlayer }
]

{ #category : 'tests' }
SkipCardTest >> test001WhenASkipCardIsPlayedThenTheShipInTurnLosesItsTurn [

	| aGame assertingVariableData |
	assertingVariableData := { 'Name: Juan, Position: 1, Lap: 0'.
							 'Name: Tomi, Position: 2, Lap: 0'.
							 'Name: Pedro, Position: 3, Lap: 0' }.
	aGame := self gameDealing: { Skip } rolling: { 1. 2 }.
	aGame player: aThirdPlayer plays: Skip create.
	self play: 2 in: aGame.
	self assert: aGame playerPositions equals: assertingVariableData
]

{ #category : 'tests' }
SkipCardTest >> test002WhenAShipLosesItsTurnBecauseOfASkipCardThenItDoesNotRecoverItsShields [

	| aGame |
	aTileListCreator at: 2 put: HyperSpaceJump create.
	aGame := self gameDealing: { Skip } rolling: { 1. 2. 4 }.
	self play: 3 in: aGame.
	aGame player: anotherPlayer plays: Skip create.
	self play: 1 in: aGame.
	self assert: (aGame shieldsFeatureOf: aPlayer) shields equals: 2.
	self assert: (aGame positionFeatureOf: aPlayer) position equals: 6
]

{ #category : 'tests' }
SkipCardTest >> test003WhenTheOrderOfTheTurnsIsReversedThenAfterASkipCardTheTurnGoesToThePreviousShip [

	| aGame assertingVariableData |
	assertingVariableData := { 'Name: Juan, Position: 1, Lap: 0'.
							 'Name: Tomi, Position: 1, Lap: 0'.
							 'Name: Pedro, Position: 2, Lap: 0' }.
	aGame := self
				 gameDealing: {
						 Reverse.
						 Skip }
				 rolling: { 1 }.
	aGame player: aPlayer plays: Reverse create.
	aGame player: aPlayer plays: Skip create.
	self play: 1 in: aGame.
	self assert: aGame playerPositions equals: assertingVariableData
]

{ #category : 'tests' }
SkipCardTest >> test004WhenARedoCardDoesASkipCardAgainThenTheNextShipInTurnLosesItsTurnToo [

	| aGame assertingVariableData |
	assertingVariableData := { 'Name: Juan, Position: 1, Lap: 0'.
							 'Name: Tomi, Position: 1, Lap: 0'.
							 'Name: Pedro, Position: 2, Lap: 0' }.
	aGame := self
				 gameDealing: {
						 Skip.
						 Redo }
				 rolling: { 1 }.
	aGame player: aPlayer plays: Skip create.
	aGame player: aPlayer plays: Redo create.
	self play: 1 in: aGame.
	self assert: aGame playerPositions equals: assertingVariableData
]
