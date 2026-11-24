Class {
	#name : 'DoubleCardTest',
	#superclass : 'GameWithCardsTestCase',
	#instVars : [
		'aThirdPlayer'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'running' }
DoubleCardTest >> setUp [

	super setUp.
	aThirdPlayer := ShipPlayerAssociation createWith: 3 and: 'Pedro'.
	aGroupOfPlayers := aGroupOfPlayers , { aThirdPlayer }
]

{ #category : 'tests' }
DoubleCardTest >> test001WhenADoubleCardIsPlayedThenTheShipInTurnThrowsTwice [

	| aGame assertingVariableData |
	assertingVariableData := { 'Name: Juan, Position: 4, Lap: 0'.
							 'Name: Tomi, Position: 5, Lap: 0'.
							 'Name: Pedro, Position: 1, Lap: 0' }.
	aGame := self gameDealing: { Double } rolling: { 1. 2. 4 }.
	aGame player: anotherPlayer plays: Double create.
	self play: 3 in: aGame.
	self assert: aGame playerPositions equals: assertingVariableData
]

{ #category : 'tests' }
DoubleCardTest >> test002WhenADoubleCardWasPlayedThenOnlyThatTurnOfTheShipIsDoubled [

	| aGame assertingVariableData |
	assertingVariableData := { 'Name: Juan, Position: 7, Lap: 0'.
							 'Name: Tomi, Position: 6, Lap: 0'.
							 'Name: Pedro, Position: 8, Lap: 0' }.
	aGame := self gameDealing: { Double } rolling: { 1. 2. 4. 7. 3 }.
	aGame player: aPlayer plays: Double create.
	self play: 6 in: aGame.
	self assert: aGame playerPositions equals: assertingVariableData
]

{ #category : 'tests' }
DoubleCardTest >> test003WhenTwoDoubleCardsArePlayedInTheSameTurnThenTheShipInTurnThrowsThreeTimes [

	| aGame assertingVariableData |
	assertingVariableData := { 'Name: Juan, Position: 8, Lap: 0'.
							 'Name: Tomi, Position: 1, Lap: 0'.
							 'Name: Pedro, Position: 1, Lap: 0' }.
	aGame := self gameDealing: { Double } rolling: { 1. 2. 4 }.
	aGame player: aPlayer plays: Double create.
	aGame player: aThirdPlayer plays: Double create.
	self play: 3 in: aGame.
	self assert: aGame playerPositions equals: assertingVariableData
]

{ #category : 'tests' }
DoubleCardTest >> test004WhenASkipCardIsPlayedInADoubledTurnThenTheShipInTurnLosesOnlyOneOfItsTwoTurns [

	| aGame assertingVariableData |
	assertingVariableData := { 'Name: Juan, Position: 2, Lap: 0'.
							 'Name: Tomi, Position: 3, Lap: 0'.
							 'Name: Pedro, Position: 1, Lap: 0' }.
	aGame := self
				 gameDealing: {
						 Double.
						 Skip }
				 rolling: { 1. 2 }.
	aGame player: aPlayer plays: Double create.
	aGame player: anotherPlayer plays: Skip create.
	self play: 2 in: aGame.
	self assert: aGame playerPositions equals: assertingVariableData
]

{ #category : 'tests' }
DoubleCardTest >> test005WhenAShipRunsOutOfShieldsInADoubledTurnThenItsExtraTurnIsOneOfTheTurnsItLoses [

	| aGame assertingVariableData |
	assertingVariableData := { 'Name: Juan, Position: 6, Lap: 0'.
							 'Name: Tomi, Position: 3, Lap: 0'.
							 'Name: Pedro, Position: 1, Lap: 0' }.
	aTileListCreator at: 2 put: (HyperSpaceJump createWith: 4 and: 3).
	aGame := self gameDealing: { Double } rolling: { 1. 2 }.
	aGame player: aPlayer plays: Double create.
	self play: 2 in: aGame.
	self assert: aGame playerPositions equals: assertingVariableData.
	self assert: (aGame turnsFeatureOf: aPlayer) turnsToSkip equals: 1
]
