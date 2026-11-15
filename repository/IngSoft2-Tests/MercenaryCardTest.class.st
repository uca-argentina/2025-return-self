Class {
	#name : 'MercenaryCardTest',
	#superclass : 'GameWithCardsTestCase',
	#instVars : [
		'aThirdPlayer'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'running' }
MercenaryCardTest >> setUp [

	super setUp.
	aThirdPlayer := ShipPlayerAssociation createWith: 3 and: 'Pedro'.
	aGroupOfPlayers := aGroupOfPlayers , { aThirdPlayer }
]

{ #category : 'tests' }
MercenaryCardTest >> test01WhenAShipWithAMercenaryBattlesThenItsMercenaryThrowsTheDiceForItToo [

	| aGame assertingVariableData |
	assertingVariableData := { 'Name: Juan, Position: 3, Lap: 0'.
							 'Name: Tomi, Position: 1, Lap: 0'.
							 'Name: Pedro, Position: 1, Lap: 0' }.
	aGame := self gameDealing: { Mercenary } rolling: { 2. 2. 1. 6. 5 }.
	aGame player: aPlayer plays: (Mercenary createWith: aThirdPlayer).
	self play: 2 in: aGame.
	self assert: aGame playerPositions equals: assertingVariableData.
	self assert: (aGame shieldsFeatureOf: anotherPlayer) shields equals: 2
]

{ #category : 'tests' }
MercenaryCardTest >> test02WhenAShipWithAMercenaryLosesABattleThenItsMercenaryLosesAShieldTooButStaysInItsTile [

	| aGame assertingVariableData |
	assertingVariableData := { 'Name: Juan, Position: 1, Lap: 0'.
							 'Name: Tomi, Position: 5, Lap: 0'.
							 'Name: Pedro, Position: 7, Lap: 0' }.
	aGame := self gameDealing: { Mercenary } rolling: { 2. 4. 6. 2. 6. 1. 2 }.
	aGame player: aPlayer plays: (Mercenary createWith: aThirdPlayer).
	self play: 4 in: aGame.
	self assert: aGame playerPositions equals: assertingVariableData.
	self assert: (aGame shieldsFeatureOf: aPlayer) shields equals: 2.
	self assert: (aGame shieldsFeatureOf: aThirdPlayer) shields equals: 2
]

{ #category : 'tests' }
MercenaryCardTest >> test03WhenAShipAndItsMercenaryAreInTheSameTileThenTheyDoNotBattle [

	| aGame assertingVariableData |
	assertingVariableData := { 'Name: Juan, Position: 3, Lap: 0'.
							 'Name: Tomi, Position: 5, Lap: 0'.
							 'Name: Pedro, Position: 3, Lap: 0' }.
	aGame := self gameDealing: { Mercenary } rolling: { 2. 4. 2 }.
	aGame player: aPlayer plays: (Mercenary createWith: aThirdPlayer).
	self play: 3 in: aGame.
	self assert: aGame playerPositions equals: assertingVariableData.
	self assert: (aGame shieldsFeatureOf: aPlayer) shields equals: 3
]

{ #category : 'tests' }
MercenaryCardTest >> test04WhenTryingToHireTheMercenaryOfAnotherShipThenItRaisesError [

	| aGame |
	aGame := self gameDealing: { Mercenary } rolling: { 2 }.
	aGame player: aPlayer plays: (Mercenary createWith: aThirdPlayer).
	self play: 1 in: aGame.
	self
		should: [
		aGame player: anotherPlayer plays: (Mercenary createWith: aThirdPlayer) ]
		raiseErrorWithMessageText: 'Cant have the same mercenary as other.'
]

{ #category : 'tests' }
MercenaryCardTest >> test05WhenAShipArrivesToATileWithARivalAndItsMercenaryThenItBattlesAgainstEachOfThemWhileItStaysThere [

	| aGame assertingVariableData |
	assertingVariableData := { 'Name: Juan, Position: 1, Lap: 0'.
							 'Name: Tomi, Position: 1, Lap: 0'.
							 'Name: Pedro, Position: 3, Lap: 0' }.
	aGame := self gameDealing: { Mercenary } rolling: { 2. 1. 2. 1. 1. 1. 5. 6. 2 }.
	aGame player: aPlayer plays: (Mercenary createWith: aThirdPlayer).
	self play: 3 in: aGame.
	self skip: 1 in: aGame.
	self play: 1 in: aGame.
	self assert: aGame playerPositions equals: assertingVariableData.
	self assert: (aGame shieldsFeatureOf: aThirdPlayer) shields equals: 2.
	self assert: (aGame shieldsFeatureOf: anotherPlayer) shields equals: 2
]

{ #category : 'tests' }
MercenaryCardTest >> test06WhenTryingToHireItselfAsAMercenaryThenItRaisesError [

	| aGame |
	aGame := self gameDealing: { Mercenary } rolling: { 2 }.
	self
		should: [ aGame player: aPlayer plays: (Mercenary createWith: aPlayer) ]
		raiseErrorWithMessageText: 'A ship cannot hire itself as a mercenary.'
]
