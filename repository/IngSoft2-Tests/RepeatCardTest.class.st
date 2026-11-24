Class {
	#name : 'RepeatCardTest',
	#superclass : 'GameWithCardsTestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'running' }
RepeatCardTest >> setUp [

	super setUp.
	aTileListCreator at: 12 put: BlackHole create
]

{ #category : 'tests' }
RepeatCardTest >> test001WhenARepeatCardIsPlayedThenTheLastEffectAppliedInTheGameIsAppliedToTheChosenShip [

	| aGame assertingVariableData |
	assertingVariableData := { 'Name: Juan, Position: 7, Lap: 0'.
							 'Name: Tomi, Position: 4, Lap: 0' }.
	aGame := self gameDealing: { Repeat } rolling: { 6. 11 }.
	self play: 2 in: aGame.
	aGame player: aPlayer plays: (Repeat createWith: anotherPlayer).
	self assert: aGame playerPositions equals: assertingVariableData
]

{ #category : 'tests' }
RepeatCardTest >> test002WhenTheLastTileAShipLandedOnHadNoEffectThenARepeatCardHasNoEffect [

	| aGame assertingVariableData |
	assertingVariableData := { 'Name: Juan, Position: 8, Lap: 0'.
							 'Name: Tomi, Position: 6, Lap: 0' }.
	aGame := self gameDealing: { Repeat } rolling: { 11. 5 }.
	self play: 2 in: aGame.
	aGame player: aPlayer plays: (Repeat createWith: aPlayer).
	self assert: aGame playerPositions equals: assertingVariableData.
	self assert: (aGame cardsFeatureOf: aPlayer) deck size equals: 1
]

{ #category : 'tests' }
RepeatCardTest >> test003WhenNobodyThrewTheDiceThenARepeatCardHasNoEffect [

	| aGame assertingVariableData |
	assertingVariableData := { 'Name: Juan, Position: 1, Lap: 0'.
							 'Name: Tomi, Position: 1, Lap: 0' }.
	aGame := self gameDealing: { Repeat } rolling: { 11 }.
	aGame player: aPlayer plays: (Repeat createWith: anotherPlayer).
	self assert: aGame playerPositions equals: assertingVariableData
]

{ #category : 'tests' }
RepeatCardTest >> test004WhenARepeatedEffectTakesAShipToATileWithARivalThenTheyBattle [

	| aGame assertingVariableData |
	assertingVariableData := { 'Name: Juan, Position: 1, Lap: 0'.
							 'Name: Tomi, Position: 4, Lap: 0' }.
	aGame := self gameDealing: { Repeat } rolling: { 3. 11. 1. 5 }.
	self play: 2 in: aGame.
	aGame player: aPlayer plays: (Repeat createWith: anotherPlayer).
	self assert: aGame playerPositions equals: assertingVariableData.
	self assert: (aGame shieldsFeatureOf: aPlayer) shields equals: 2
]

{ #category : 'tests' }
RepeatCardTest >> test005WhenAnInstantCardIsPlayedOutOfTheTurnOfTheShipThenItHasEffect [

	| aGame |
	aGame := self gameDealing: { Repeat } rolling: { 11 }.
	self play: 1 in: aGame.
	aGame player: aPlayer plays: (Repeat createWith: aPlayer).
	self assert: (aGame positionFeatureOf: aPlayer) position equals: 4
]
