Class {
	#name : 'ReverseCardTest',
	#superclass : 'GameWithCardsTestCase',
	#instVars : [
		'aThirdPlayer'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'running' }
ReverseCardTest >> setUp [

	super setUp.
	aThirdPlayer := ShipPlayerAssociation createWith: 3 and: 'Pedro'.
	aGroupOfPlayers := aGroupOfPlayers , { aThirdPlayer }
]

{ #category : 'tests' }
ReverseCardTest >> test01WhenAReverseCardIsPlayedThenAfterTheShipInTurnTheTurnsGoTheOtherWayAround [

	| aGame assertingVariableData |
	assertingVariableData := { 'Name: Juan, Position: 2, Lap: 0'.
							 'Name: Tomi, Position: 1, Lap: 0'.
							 'Name: Pedro, Position: 3, Lap: 0' }.
	aGame := self gameDealing: { Reverse } rolling: { 1. 2 }.
	aGame player: anotherPlayer plays: Reverse create.
	self play: 2 in: aGame.
	self assert: aGame playerPositions equals: assertingVariableData
]

{ #category : 'tests' }
ReverseCardTest >> test02WhenAnotherReverseCardIsPlayedThenTheTurnsGoInTheOriginalOrderAgain [

	| aGame assertingVariableData |
	assertingVariableData := { 'Name: Juan, Position: 5, Lap: 0'.
							 'Name: Tomi, Position: 1, Lap: 0'.
							 'Name: Pedro, Position: 3, Lap: 0' }.
	aGame := self gameDealing: { Reverse } rolling: { 1. 2. 3 }.
	aGame player: aPlayer plays: Reverse create.
	self play: 1 in: aGame.
	aGame player: anotherPlayer plays: Reverse create.
	self play: 2 in: aGame.
	self assert: aGame playerPositions equals: assertingVariableData
]

{ #category : 'tests' }
ReverseCardTest >> test03WhenTheOrderOfTheTurnsIsReversedThenThePermanentCardsFollowTheNewOrder [

	| aGame |
	aGame := self
				 gameDealing: {
						 Reverse.
						 Speed }
				 rolling: { 1. 2 }.
	aGame player: aPlayer plays: Reverse create.
	self play: 1 in: aGame.
	self
		should: [ aGame player: anotherPlayer plays: (Speed createWith: anotherPlayer) ]
		raiseErrorWithMessageText:
		'Permanent cards can only be played during the turn of the ship.'.
	aGame player: aThirdPlayer plays: (Speed createWith: aThirdPlayer).
	self play: 1 in: aGame.
	self assert: (aGame positionFeatureOf: aThirdPlayer) position equals: 4
]
