Class {
	#name : 'SpeedCardTest',
	#superclass : 'GameWithCardsTestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
SpeedCardTest >> test001WhenASpeedCardIsPlayedThenTheChosenShipAdvancesOneMoreTileOnEveryThrow [

	| aGame assertingVariableData |
	assertingVariableData := { 'Name: Juan, Position: 5, Lap: 0'.
							 'Name: Tomi, Position: 4, Lap: 0' }.
	aGame := self gameDealing: { Speed } rolling: { 3 }.
	aGame player: aPlayer plays: (Speed createWith: aPlayer).
	self play: 2 in: aGame.
	self assert: aGame playerPositions equals: assertingVariableData
]

{ #category : 'tests' }
SpeedCardTest >> test002WhenACardIsPlayedThenItIsNoLongerInTheHandOfTheShip [

	| aGame |
	aGame := self gameDealing: { Speed } rolling: { 3 }.
	aGame player: aPlayer plays: (Speed createWith: aPlayer).
	self assert: (aGame cardsFeatureOf: aPlayer) deck size equals: 1
]

{ #category : 'tests' }
SpeedCardTest >> test003WhenTryingToPlayACardThatIsNotInTheHandOfTheShipThenItRaisesError [

	| aGame |
	aGame := self gameDealing: { Repeat } rolling: { 3 }.
	self
		should: [ aGame player: aPlayer plays: (Speed createWith: aPlayer) ]
		raiseErrorWithMessageText: 'Player does not have this card on deck.'
]
